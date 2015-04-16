require 'monkey_learn'

require 'dotenv'
Dotenv.load

api_key = ENV['API_KEY']
classifier_id = ENV['CLASSIFIER_ID']
should_use_sandbox = true

classifier = MonkeyLearn::Classifier.new(api_key, classifier_id, should_use_sandbox)

text1 = "Where can I find good coffee?"
text2 = "What time is it?"
response = classifier.classify(text1, text2)

puts "Response code : #{response.code}"
response.text_results.each do |text_result|
  text_result.each do |classifier_result|
    puts "- #{classifier_result.label} (#{classifier_result.probability})"
  end  
end  
