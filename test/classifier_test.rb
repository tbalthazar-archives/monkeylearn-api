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

  def test_classify_gets_a_correct_response
    classifier = MonkeyLearn::Classifier.new(@api_key, @classifier_id)
    classifier_response = classifier.classify("foo", "bar")
    assert_equal 200, classifier_response.code 
    assert_equal 2, classifier_response.text_results.count
    assert_equal 2, classifier_response.text_results[0].count
    assert_equal 1, classifier_response.text_results[1].count
  end

end
