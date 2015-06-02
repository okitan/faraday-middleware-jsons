module FaradayMiddleware::Jsons
  class Decoder < Faraday::Middleware
    def initialize(app, options = {})
      super(app)

      @raise_error    = options[:raise_error]    || false
      @symbolize_keys = options[:symbolize_keys] || false
      @content_type   = options[:content_type]   || %r!^application/(.*\+)?json!
    end

    def call(env)
      @app.call(env).on_complete do |env|
        if has_body?(env) && match_content_type?(env)
          env[:body] = parse(env[:body])
        end
      end
    end

    def parse(body)
      begin
        ::MultiJson.load(body, symbolize_keys: @symbolize_keys)
      rescue => e
        raise e if @raise_error
        body
      end
    end

    protected
    def match_content_type?(env)
      content_type = env[:response_headers]["Content-Type"]
      @content_type === content_type
    end

    def has_body?(env)
      (body = env[:body]) && !body.empty?
    end
  end
end
