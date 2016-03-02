require "spec_helper"

RSpec.describe FaradayMiddleware::Jsons::Encoder do
  let(:object) { { "hoge" => "fuga" } }

  def connection(options = {}, &block)
    Faraday.new("http://example.com/api") do |conn|
      block.call(conn) if block_given?

      conn.request :jsons, options
      conn.headers["Content-Type"] = (options[:request_content_type] || "application/json")

      conn.adapter :test do |stub|
        stub.post("/") do |env|
          [ 200, { debug: env[:request_headers]["Content-Type"] }, env[:body] ]
        end
      end
    end
  end

  context "encode json" do
    before do
      @response = connection.post("/", object)
    end

    it "works" do
      expect(@response.body).to eq(MultiJson.dump(object))
    end
  end

  context "when body" do
    context "is nil" do
      before do
        @response = connection.post("/", nil)
      end

      it "works" do
        expect(@response.body).to eq("null")
      end
    end
  end

  context "when content_type:" do
    %w[ application/patch+json application/hal+json ].each do |type|
      context "is #{type}" do
        before do
          @response = connection(request_content_type: type).post("/", object)
        end

        it "encodes json" do
          expect(@response.body).to eq(MultiJson.dump(object))
        end
      end
    end

    context "is not json" do
      before do
        @response = connection(request_content_type: "application/x-www-form-urlencoded").post("/", object)
      end

      it "does not encode json" do
        expect(@response.body).to eq(object)
      end
    end
  end

  context "when pretty:" do
    context "is true" do
      before do
        @response = connection(pretty: true).post("/", object)
      end

      it "encodes pretty json" do
        expect(@response.body).to eq(MultiJson.dump(object, pretty: true))
      end
    end
  end
end
