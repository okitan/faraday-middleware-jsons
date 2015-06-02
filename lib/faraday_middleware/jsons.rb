require "faraday"
require "multi_json"

module FaradayMiddleware
  module Jsons
    # basic json support
    require "faraday_middleware/jsons/request/encoder"
    require "faraday_middleware/jsons/response/decoder"

    Faraday::Request.register_middleware(
      jsons: -> { ::FaradayMiddleware::Jsons::Encoder }
    )

    Faraday::Response.register_middleware(
      jsons: -> { ::FaradayMiddleware::Jsons::Decoder }
    )
  end
end
