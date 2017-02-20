require 'rails_helper'

feature 'Create question', %q{
  In order to ask people about something
  As an authenticated user
  I want to be able to ask questions
} do

  given(:user) { create(:user) }
  given(:question) { create(:question) }

  scenario 'Authenticated user creates a question with valid attributes' do
    sign_in(user)

    visit questions_path
    click_on 'Ask Question'
    fill_in 'Title', with: question.title
    fill_in 'Body', with: question.body
    click_on 'Create'


    expect(page).to have_content question.title
    expect(page).to have_content question.body
  end

  scenario 'Authenticated user creates a question with invalid attributes' do
    sign_in(user)

    visit questions_path
    click_on 'Ask Question'
    fill_in 'Title', with: nil
    fill_in 'Body', with: nil
    click_on 'Create'


    expect(page).to have_no_content question.title
    expect(page).to have_no_content question.body
  end
end