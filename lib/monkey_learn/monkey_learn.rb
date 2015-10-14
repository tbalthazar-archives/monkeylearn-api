require 'net/http'
require 'uri'
require 'json'

module MonkeyLearn

  class MonkeyLearn
    attr_accessor :open_timeout, :read_timeout

    DEFAULT_TIMEOUT = 30

    @@base_uri = "https://api.monkeylearn.com/v2"

    def initialize(api_key:, open_timeout: nil, read_timeout: nil)
      @api_key = api_key
      @open_timeout = open_timeout || DEFAULT_TIMEOUT
      @read_timeout = read_timeout || DEFAULT_TIMEOUT
    end

    def build_post_request(uri:, body:)
      request = Net::HTTP::Post.new(uri.request_uri)
      request.body = body.to_json
      request.add_field("Content-Type", "application/json")
      request.add_field("Authorization", "token #{@api_key}")
      return request
    end

    def build_http_object(uri:)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = uri.scheme == 'https'
      http.open_timeout = @open_timeout
      http.read_timeout = @read_timeout
      return http
    end

  end

end
