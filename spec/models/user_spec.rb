require 'rails_helper'

RSpec.describe User, type: :model do
  it { should validate_presence_of :email }
  it { should validate_presence_of :password }

describe "author_of?" do
	let(:user) { create(:user) }
	let(:user2) { create(:user) }
	let(:question) { create(:question, user: user) }
	let(:answer) { create(:answer, user: user, question: question) }

	context "user is author" do
		it "user_id and question_id" do
			expect(user).to be_author_of(question)
		end

		it "user_id and question_id" do
			expect(user).to be_author_of(answer)
		end
	end

	context "user2 is not author" do
		it "user_id and question_id" do
			expect(user2).to_not be_author_of(question)
		end

		it "user_id and question_id" do
			expect(user2).to_not be_author_of(answer)
		end
	end
  end
end
