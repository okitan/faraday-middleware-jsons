module FaradayMiddleware::Jsons
  class Encoder < Faraday::Middleware
    def initialize(app, options = {})
      super(app)

      @pretty       = options.delete(:pretty)       || false
      @content_type = options.delete(:content_type) || %r!^application/(.*\+)?json!
      @options      = options
    end

    def call(env)
      if has_body?(env) && match_content_type?(env)
        # do not encode multiple times when the same middleware is decrared
        # unicode string is valid for json (but escaping is also skipped...)
        env[:body] = MultiJson.dump(env[:body], @options.merge(pretty: @pretty)) unless env[:body].is_a?(String)
      end

      @app.call(env)
    end

    protected
    def match_content_type?(env)
      content_type = env[:request_headers]["Content-Type"]
      @content_type === content_type
    end

    def has_body?(env)
      (body = env[:body]) && !body.empty?
    end
  end
end
