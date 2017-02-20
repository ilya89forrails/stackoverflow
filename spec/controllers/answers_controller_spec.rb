require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  sign_in_user
  let(:question) { create(:question) }
  let(:answer) { create(:answer, question: question) }

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'saves the new answer in the database' do
        expect { post :create, question_id: question, answer: attributes_for(:answer) }.to change(question.answers, :count).by(1)
      end

      it 'redirects to show view' do
        post :create, question_id: question, answer: attributes_for(:answer)
        expect(response).to redirect_to(question_path(question))
      end
    end
  end

  describe 'DELETE #destroy' do
 
      let(:question) { create(:question) }

      sign_in_user

      context 'author of answer' do
        let(:answer) { create(:answer, user_id: @user.id, question_id: question.id) }

        it 'destroys answer to question' do
          params = { question_id: question.id, id: answer.id }
          expect { delete :destroy, params: params }.to change(question.answers, :count).by(-1)
        end

        it 'redirect to question' do
          params = { question_id: question.id, id: answer.id }
          delete :destroy, params: params
          expect(response).to redirect_to(question_path(question))
        end
      end
    end
end
