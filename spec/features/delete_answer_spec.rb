require 'rails_helper'

feature 'Delete answer', '
  In order to delete my answer
  As an author of the answer
  I want to be able to delete the answer
' do
  given(:user) { create(:user) }
  given(:user2) { create(:user, email: 'qqqqqq@test.com') }
  given(:question) { create(:question, user: user) }
  given!(:answer) { create(:answer, question: question, user: user2) }

  scenario 'Authenticated user deletes his own answer' do
    sign_in(user2)

    visit question_path(question)
    click_on 'Delete answer'

    expect(page).to have_content 'The answer has been successfully deleted.'
    expect(page).to have_no_content answer.body
  end

  scenario 'Authenticated user deletes other answer' do
    sign_in(user)

    visit question_path(question)
    expect(page).to have_no_link 'Delete answer'
  end

  scenario 'Non-authenticated user deletes a answer' do
    visit question_path(question)
    expect(page).to have_no_link 'Delete answer'
  end
end
