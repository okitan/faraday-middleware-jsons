module FaradayMiddleware::Jsons
  class Encoder < Faraday::Middleware
    def initialize(app, options = {})
      super(app)

      @pretty       = options.delete(:pretty)       || false
      @content_type = options.delete(:content_type) || %r!^application/(.*\+)?json!
      @options      = options
    end

    def call(env)
      if match_http_method?(env) && match_content_type?(env)
        # do not encode multiple times when the same middleware is decrared
        # unicode string is valid for json (but escaping is also skipped...)
        env[:body] = MultiJson.dump(env[:body], @options.merge(pretty: @pretty)) unless env[:body].is_a?(String)
      end

      @app.call(env)
    end

    protected
    # without this check env.clear_body is eventually called before passing env to adapter
    def match_http_method?(env)
      # env.needs_body? checks body exist
      Faraday::Env::MethodsWithBodies.include?(env.method)
    end

    def match_content_type?(env)
      content_type = env[:request_headers]["Content-Type"]
      @content_type === content_type
    end
  end
end
