FactoryGirl.define do
  factory :question do
    title 'sample_question_title'
    body 'sample_question_body'
  end

  factory :invalid_question, class: 'Question' do
    title nil
    body nil
  end
end
