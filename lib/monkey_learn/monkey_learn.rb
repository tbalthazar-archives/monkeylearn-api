require 'net/http'
require 'uri'
require 'json'

module MonkeyLearn

  class MonkeyLearn

    @@base_uri = "https://api.monkeylearn.com/v2"

    def initialize(api_key)
      @api_key = api_key
    end

    def build_post_request_with_uri(uri, body)
      request = Net::HTTP::Post.new(uri.request_uri)
      request.body = body.to_json
      request.add_field("Content-Type", "application/json")
      request.add_field("Authorization", "token #{@api_key}")
      return request
    end

    def build_http_object_with_uri(uri)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = uri.scheme == 'https'
      return http
    end

  end

end
