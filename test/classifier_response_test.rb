require File.dirname(__FILE__) + '/helper'

class ClassifierResponseTest < MiniTest::Test

  def setup
    @response_hash = fixture_for("classifier_response")
    @http_response = FakeHTTPResponse.new(200, @response_hash.to_json)
  end

  def test_build_object_from_hash
    classifier_response = MonkeyLearn::ClassifierResponse.new(@http_response) 
    assert_equal 2, classifier_response.text_results.count
    assert_equal 2, classifier_response.text_results.first.count
    assert_equal 1, classifier_response.text_results.last.count

    classifier_result1 = classifier_response.text_results[0][0]
    assert_equal 0.246, classifier_result1.probability
    assert_equal "Health & Medicine", classifier_result1.label

    classifier_result2 = classifier_response.text_results[0][1]
    assert_equal 0.654, classifier_result2.probability
    assert_equal "Alternative Medicine", classifier_result2.label

    classifier_result3 = classifier_response.text_results[1][0]
    assert_equal 0.172, classifier_result3.probability
    assert_equal "Humanities", classifier_result3.label
  end

  def test_response_without_result_raises_error
    @response_hash.delete(:result)
    @http_response = FakeHTTPResponse.new(200, @response_hash.to_json)
    assert_raises MonkeyLearn::ClassifierResponseError do
      classifier_response = MonkeyLearn::ClassifierResponse.new(@http_response) 
    end
  end

end
