require File.dirname(__FILE__) + '/helper'
require 'fakeweb'

class MonkeyLearnTest < MiniTest::Test

  def setup
    @api_key = "fake_api_123"
    @body = fixture_for("classifier_response")
    @uri = URI.parse("https://www.example.com/foo/bar")
  end

  def test_build_post_request
    monkey_learn = MonkeyLearn::MonkeyLearn.new(@api_key)
    request = monkey_learn.build_post_request_with_uri(@uri, @body) 
    assert_equal "POST", request.method
    assert_equal @uri.path, request.path
    assert_equal @body.to_json, request.body
    assert_equal "application/json", request['Content-Type']
    assert_equal "token #{@api_key}", request['Authorization']
  end

end
