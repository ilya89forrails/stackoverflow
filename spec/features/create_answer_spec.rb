require 'rails_helper'

feature 'Create answer', '
  In order to help other users
  As an authenticated user
  I want to be able to answer to question
' do
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

  scenario 'Authenticated user trying to create answer with invalid attributes' do
    sign_in(user)

    visit question_path(question)

    fill_in 'Answer', with: nil
    click_on 'Submit'
    
    expect(current_path).to eq question_path(question)
    expect(page).to have_content 'The answer cant be created.'
  end

  scenario 'Unauthenticated user trying to create answer' do
    visit question_path(question)

    fill_in 'Answer', with: answer.body
    click_on 'Submit'

    expect(current_path).to eq new_user_session_path
  end
end
