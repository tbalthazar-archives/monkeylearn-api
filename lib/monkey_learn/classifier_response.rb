module MonkeyLearn

  class ClassifierResponseError < StandardError
    attr_reader :http_response

    def initialize(http_response)
      @http_response = http_response
      code = @http_response.code
      body = JSON.parse(http_response.body, {symbolize_names: true})
      
      msg =  "An error has occured while processing the response. Status code :  #{code}"
      if body[:detail]
        msg += " - Detail : #{body[:detail]}"
      else
        msg += " - Body : #{body.inspect}"
      end

      super msg
    end
  end

  class ClassifierResponse
    attr_reader :http_response
    attr_reader :text_results
    
    def initialize(http_response)
      @http_response = http_response
      if @http_response.code.to_i == 200
        @text_results = parse_response_body(@http_response.body)
      else
        @text_results = []
        raise ClassifierResponseError.new @http_response
      end
    end

    def code
      return @http_response.code.to_i
    end

    private

    # {"result": [
    #   [ // Text 1
    #     {"probability": 0.246, "label": "Health & Medicine"},
    #     {"probability": 0.654, "label": "Alternative Medicine"}
    #   ], [ // Text 2
    #     {"probability": 0.172, "label": "Humanities"}
    #   ]
    # ]}
    def parse_response_body(body)
      begin
        body_hash = JSON.parse(body, {symbolize_names: true})
        text_results = []
        body_hash[:result].each do |text_result|
          classifier_results = []
          text_result.each do |classifier_result_hash|
            classifier_results << ClassifierResult.new(classifier_result_hash) 
          end
          text_results << classifier_results
        end

        return text_results
      rescue
        raise ClassifierResponseError.new @http_response
      end
    end

  end

end
