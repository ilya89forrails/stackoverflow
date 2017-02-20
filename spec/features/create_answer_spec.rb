require 'rails_helper'

feature 'Create answer', %q{
  In order to help other users
  As an authenticated user
  I want to be able to answer to question
} do

  given(:user) { create(:user) }
  given!(:question) { create(:question) }
  given!(:answer) { create(:answer) }

  scenario 'Authenticated user can create answer with valid attributes' do
    sign_in(user)

    visit question_path(question)

    fill_in 'Answer', with: answer.body
    click_on 'Submit'

    expect(current_path).to eq question_path(question)
    expect(page).to have_content answer.body
  end
end

