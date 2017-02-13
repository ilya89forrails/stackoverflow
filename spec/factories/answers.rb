FactoryGirl.define do
  factory :answer do
    body 'sample_answer_body'
  end

  factory :invalid_answer, class: 'Answer' do
    body nil
  end
end
