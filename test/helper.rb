$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'minitest/autorun'
require 'monkey_learn'

class FakeHTTPResponse
  attr_reader :code, :body

  def initialize(code, body)
    @code = code
    @body = body
  end

end

def fixture_for(filename)
  filename = "#{filename}.json"
  file_path = File.expand_path(File.dirname(__FILE__) + '/fixtures/' + filename)
  file_content = File.read(file_path)
  return JSON.parse(file_content, {symbolize_names: true})
end
