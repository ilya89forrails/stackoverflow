require 'rails_helper'

feature 'Create answer', '
  In order to help other users
  As an authenticated user
  I want to be able to answer to question
' do
  given(:user) { create(:user) }
  given!(:question) { create(:question) }
  given!(:answer) { create(:answer) }

  scenario 'Authenticated user can create answer with valid attributes', js: true do
    sign_in(user)

    visit question_path(question)

    fill_in 'Answer', with: answer.body
    click_on 'Submit'

    expect(current_path).to eq question_path(question)
    #expect(page).to have_content answer.body
    within '.answers' do
        expect(page).to have_content answer.body
    end
  end

  scenario 'Authenticated user trying to create answer with invalid attributes', js: true do
    sign_in(user)

    visit question_path(question)

    fill_in 'Answer', with: nil
    click_on 'Submit'

    #expect(page).to have_content 'Body can\'t be blank'
    expect(current_path).to eq question_path(question)
    within '.answers' do
      expect(page).to have_no_content answer.body
    end
  end

  scenario 'Unauthenticated user trying to create answer' do
    visit question_path(question)

    fill_in 'Answer', with: answer.body
    click_on 'Submit'

    expect(current_path).to eq new_user_session_path
  end
end
