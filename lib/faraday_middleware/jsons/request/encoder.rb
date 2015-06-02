module FaradayMiddleware::Jsons
  class Encoder < Faraday::Middleware
    def initialize(app, options = {})
      super(app)

      @pretty       = options[:pretty]       || false
      @content_type = options[:content_type] || %r!^application/(.*\+)?json!
    end

    def call(env)
      if has_body?(env) && match_content_type?(env)
        env[:body] = MultiJson.dump(env[:body], pretty: @pretty)
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
