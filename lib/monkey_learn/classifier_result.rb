module MonkeyLearn

  class ClassifierResultError < StandardError
    attr_reader :result_hash

    def initialize(result_hash)
      @result_hash = result_hash
      msg = "An error has occured while creating the object. A property is probably missing : #{result_hash.inspect}"
      super msg
    end

  end

  class ClassifierResult
    attr_reader :probability
    attr_reader :label

    def initialize(result_hash)
      if !result_hash.is_a?(Hash) ||
          result_hash[:probability].nil? ||
          result_hash[:label].nil?
        raise ClassifierResultError.new result_hash
      else
        @probability = result_hash[:probability]
        @label = result_hash[:label]
      end
    end

  end

end
