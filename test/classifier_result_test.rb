require File.dirname(__FILE__) + '/helper'

class ClassifierResultTest < MiniTest::Test

  def setup
    @result_hash = fixture_for("classifier_result")
  end

  def test_build_object_from_hash
    classifier_result = MonkeyLearn::ClassifierResult.new(@result_hash)
    assert_equal classifier_result.probability, @result_hash[:probability]
    assert_equal classifier_result.label, @result_hash[:label]
  end

  def test_hash_without_probability_raises_error
    @result_hash.delete(:probability)
    assert_raises MonkeyLearn::ClassifierResultError do
      MonkeyLearn::ClassifierResult.new(@result_hash)
    end
  end

  def test_hash_without_label_raises_error
    @result_hash.delete(:label)
    assert_raises MonkeyLearn::ClassifierResultError do
      MonkeyLearn::ClassifierResult.new(@result_hash)
    end
  end

  def test_empty_hash_raises_error
    @result_hash.delete(:probability)
    @result_hash.delete(:label)
    assert_raises MonkeyLearn::ClassifierResultError do
      MonkeyLearn::ClassifierResult.new(@result_hash)
    end
  end

  def test_nil_hash_raises_error
    @result_hash = nil
    assert_raises MonkeyLearn::ClassifierResultError do
      MonkeyLearn::ClassifierResult.new(@result_hash)
    end
  end

end
