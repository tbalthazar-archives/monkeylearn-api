module MonkeyLearn

  class Classifier < MonkeyLearn

    def initialize(api_key:, classifier_id:, should_use_sandbox: false)
      super(api_key: api_key)
      @classifier_id = classifier_id
      @should_use_sandbox = should_use_sandbox
    end

    def classify(*text_list)
      body = { text_list: text_list }

      uri_string = @@base_uri
      uri_string += "/classifiers/#{@classifier_id}/classify/"
      uri_string += "?sandbox=1" if @should_use_sandbox
      uri = URI.parse(uri_string)

      request = build_post_request(uri: uri, body: body)
      http = build_http_object(uri: uri)
      
      response = http.request(request)
      return ClassifierResponse.new(response)
    end

  end

end
