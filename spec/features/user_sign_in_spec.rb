require 'rails_helper'

feature 'User sign in', '
  In order to be able to ask a question or answer
  As an authenticated user
  I want to be able to sign in
' do
  given(:user) { create(:user) }

  scenario 'Registered user tries to sign in' do
    sign_in(user)

    expect(page).to have_content 'Signed in successfully.'
    expect(current_path).to eq root_path
  end

  scenario 'Non-registered user tries to sign in' do
    visit new_user_session_path
    fill_in 'Email', with: 'test@test.com'
    fill_in 'Password', with: '12345678'
    click_on 'Log in'

    expect(page).to have_content 'Invalid Email or password'
    expect(current_path).to eq new_user_session_path
  end

  scenario 'User tries to sign in with empty fields' do
    visit new_user_session_path
    fill_in 'Email', with: nil
    fill_in 'Password', with: nil
    click_on 'Log in'

    expect(page).to have_content 'Invalid Email or password'
    expect(current_path).to eq new_user_session_path
  end

  scenario 'Signed user tries to sign in' do
    sign_in(user)

    visit new_user_session_path

    expect(page).to have_content 'You are already signed in'
    expect(current_path).to eq root_path
  end
end
