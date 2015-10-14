require File.dirname(__FILE__) + '/helper'
require 'fakeweb'

class ClassifierTest < MiniTest::Test

  def monkey_learn_url(path)
    url = "https://api.monkeylearn.com/v2"
    url+= path
    return url
  end

  def setup
    @api_key = "fake_api_123"
    @classifier_id = "fake_clasifier_123"
    @url = monkey_learn_url("/classifiers/#{@classifier_id}/classify/")
    @body = fixture_for("classifier_response").to_json
    FakeWeb.register_uri(:post, @url, :body => @body) 
  end

  def test_timeout_params_are_passed_properly
    open_timeout = MonkeyLearn::MonkeyLearn::DEFAULT_TIMEOUT + 1
    read_timeout = MonkeyLearn::MonkeyLearn::DEFAULT_TIMEOUT + 2
    uri = URI.parse('https://example.com/foo/bar')

    classifier = MonkeyLearn::Classifier.new(api_key: @api_key,
                                             classifier_id: @classifier_id,
                                             open_timeout: open_timeout,
                                             read_timeout: read_timeout)
    http_object = classifier.build_http_object(uri: uri)
    
    assert_equal open_timeout, http_object.open_timeout
    assert_equal read_timeout, http_object.read_timeout
  end

  def test_classify_gets_a_correct_response
    classifier = MonkeyLearn::Classifier.new(api_key: @api_key,
                                             classifier_id: @classifier_id)
    classifier_response = classifier.classify("foo", "bar")
    assert_equal 200, classifier_response.code 
    assert_equal 2, classifier_response.text_results.count
    assert_equal 2, classifier_response.text_results[0].count
    assert_equal 1, classifier_response.text_results[1].count
  end

end
