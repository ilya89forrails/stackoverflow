require 'rails_helper'

RSpec.describe Answer, type: :model do
  it { is_expected.to belong_to(:question) }

  it { should validate_presence_of :body }
  it { should validate_presence_of :question_id }
end