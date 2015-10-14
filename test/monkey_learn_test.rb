require File.dirname(__FILE__) + '/helper'
require 'fakeweb'

class MonkeyLearnTest < MiniTest::Test

  def setup
    @api_key = "fake_api_123"
    @body = fixture_for("classifier_response")
    @uri = URI.parse("https://www.example.com/foo/bar")
  end

  def test_build_post_request
    monkey_learn = MonkeyLearn::MonkeyLearn.new(api_key: @api_key)
    request = monkey_learn.build_post_request(uri: @uri, body: @body) 
    assert_equal "POST", request.method
    assert_equal @uri.path, request.path
    assert_equal @body.to_json, request.body
    assert_equal "application/json", request['Content-Type']
    assert_equal "token #{@api_key}", request['Authorization']
  end

  def test_build_http_object_set_default_timeout_values
    open_timeout = MonkeyLearn::MonkeyLearn::DEFAULT_TIMEOUT
    read_timeout = MonkeyLearn::MonkeyLearn::DEFAULT_TIMEOUT

    monkey_learn = MonkeyLearn::MonkeyLearn.new(api_key: @api_key)
    http_object = monkey_learn.build_http_object(uri: @uri)
    
    assert_equal open_timeout, http_object.open_timeout
    assert_equal read_timeout, http_object.read_timeout
  end

  def test_build_http_object_uses_timeout_values_specified_at_init
    open_timeout = MonkeyLearn::MonkeyLearn::DEFAULT_TIMEOUT + 1
    read_timeout = MonkeyLearn::MonkeyLearn::DEFAULT_TIMEOUT + 2

    monkey_learn = MonkeyLearn::MonkeyLearn.new(api_key: @api_key,
                                                open_timeout: open_timeout,
                                                read_timeout: read_timeout)
    http_object = monkey_learn.build_http_object(uri: @uri)
    
    assert_equal open_timeout, http_object.open_timeout
    assert_equal read_timeout, http_object.read_timeout
  end

  def test_build_http_object_uses_specified_timeout_values
    open_timeout = MonkeyLearn::MonkeyLearn::DEFAULT_TIMEOUT + 1
    read_timeout = MonkeyLearn::MonkeyLearn::DEFAULT_TIMEOUT + 2

    monkey_learn = MonkeyLearn::MonkeyLearn.new(api_key: @api_key)
    monkey_learn.open_timeout = open_timeout
    monkey_learn.read_timeout = read_timeout
    http_object = monkey_learn.build_http_object(uri: @uri)
    
    assert_equal open_timeout, http_object.open_timeout
    assert_equal read_timeout, http_object.read_timeout
  end

end
