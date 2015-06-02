require "spec_helper"

RSpec.describe FaradayMiddleware::Jsons::Decoder do
  let(:object) { { "hoge" => "fuga" } }

  def connection(content_type = "application/json", body = MultiJson.dump(object),
                 options = {}, &block)
    Faraday.new("http://example.com/api") do |conn|
      block.call(conn) if block_given?

      conn.response :jsons, options

      conn.adapter :test do |stub|
        stub.get("/") do |env|
          [ 200, { "Content-Type" => content_type }, body ]
        end
      end
    end
  end

  context "decode json" do
    before do
      @response = connection.get("/")
    end

    it "works" do
      expect(@response.body).to eq(object)
    end
  end

  context "when content_type:" do
    %w[ application/patch+json application/hal+json ].each do |type|
      context "is #{type}" do
        before do
          @response = connection(type).get("/")
        end

        it "encodes json" do
          expect(@response.body).to eq(object)
        end
      end
    end

    context "is not json" do
      before do
        @response = connection("text/plain").get("/")
      end

      it "does not encode json" do
        expect(@response.body).to eq(MultiJson.dump(object))
      end
    end
  end

  context "when symbolize_keys:" do
    context "is true" do
        before do
          @response = connection("application/json", MultiJson.dump(object), symbolize_keys: true).get("/")
        end

        it "encodes json" do
          expect(@response.body).to eq(hoge: "fuga")
        end
    end
  end
  context "when raise_error:" do
    context "is true" do
      it "encodes pretty json" do
        expect { connection("application/json", "}", raise_error: true).get("/") }.to raise_exception
      end
    end

    context "is false" do
      it "encodes pretty json" do
        expect(connection("application/json", "}", raise_error: false).get("/").body).to eq("}")
      end
    end
  end
end
