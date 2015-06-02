# FaradayMiddleware::Jsons

[![Build Status](https://travis-ci.org/okitan/faraday_middleware-jsons.svg?branch=master)](https://travis-ci.org/okitan/faraday_middleware-jsons)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'faraday_middleware-jsons'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install faraday_middleware-jsons

## Usage

```ruby
require "faraday_middleware/jsons"

Faraday.new "http://example.com/api" do |conn|
  conn.request :jsons, content_type: /application\/json/, pretty: true
end
```

### Request Middleware

#### :jsons

Serialize as json if Content-Type matched.
Defalut allows to searialize many variety of json type such as patch+json, hal+json.

Options:

| key | description | default |
|-----|-------------|---------|
| :content_type | To be compared with Content-Type using === | /application\/(.*\+)?json/ |
| :pretty       | To be passed to MultiJson | false |

## Contributing

1. Fork it ( https://github.com/[my-github-username]/faraday-middleware-jsons/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
