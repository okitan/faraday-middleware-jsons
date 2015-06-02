require "faraday"
require "multi_json"

module FaradayMiddleware
  module Jsons
    # basic json support
    require "faraday_middleware/jsons/request/encoder"
    #require "faraday_middleware/jsons/response/json"

    Faraday::Request.register_middleware(
      jsons: -> { ::FaradayMiddleware::Jsons::Encoder }
    )
  end
end
