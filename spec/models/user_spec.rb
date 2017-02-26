require 'rails_helper'

RSpec.describe User, type: :model do
  it { should validate_presence_of :email }
  it { should validate_presence_of :password }

  describe 'author_of?' do
    let(:user) { create(:user) }
    let(:user2) { create(:user) }
    let(:question) { create(:question, user: user) }

    it 'user is author of question' do
      expect(user).to be_author_of(question)
    end

    it 'user is not author of question' do
      expect(user2).to_not be_author_of(question)
    end
  end
end
