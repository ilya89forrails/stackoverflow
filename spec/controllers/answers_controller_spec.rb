require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  context 'user is signed in' do
    sign_in_user
    let(:question) { create(:question) }
    let(:answer) { create(:answer, question: question) }

    describe 'POST #create' do
      context 'with valid attributes' do
        it 'assigns the new answer to the @user' do
          post :create, params: { question_id: question, answer: attributes_for(:answer) }
          expect(assigns(:answer).user).to eq @user
        end

        it 'saves the new answer in the database' do
          expect { post :create, question_id: question, answer: attributes_for(:answer) }.to change(question.answers, :count).by(1)
        end

        it 'redirects to show view' do
          post :create, question_id: question, answer: attributes_for(:answer)
          expect(response).to redirect_to(question_path(question))
        end
      end

      context 'with invalid attributes' do
        it 'does not save the new question in the database' do
          expect { post :create, params: { question_id: question, answer: attributes_for(:invalid_answer) } }.to_not change(Answer, :count)
        end

        it 're-render question' do
          post :create, params: { question_id: question, answer: attributes_for(:invalid_answer) }
          expect(response).to render_template 'questions/show'
        end
      end
    end
  end

  context 'user is not signed in' do
    let(:question) { create(:question) }
    it 'does not save the new answer in the database' do
      expect { post :create, params: { question_id: question, answer: attributes_for(:answer) } }.to_not change(Answer, :count)
    end

    it 'not redirects to show view' do
      post :create, question_id: question, answer: attributes_for(:answer)
      expect(response).to_not redirect_to(question_path(question))
    end
  end

  describe 'DELETE #destroy' do
    let(:question) { create(:question) }

    sign_in_user

    context 'author of answer' do
      let(:answer) { create(:answer, user_id: @user.id, question_id: question.id) }

      it 'destroys answer to question' do
        params = { question_id: question.id, id: answer.id }
        expect { delete :destroy, params: params }.to change(Answer, :count).by(-1)
      end

      it 'redirect to question' do
        params = { question_id: question.id, id: answer.id }
        delete :destroy, params: params
        expect(response).to redirect_to(question_path(question))
      end
    end

    context 'user is not the author of the answer' do
      let(:user2) { create(:user, email: 'test@test.com') }
      let(:answer) { create(:answer, user_id: user2.id, question_id: question.id) }

      it 'cant destroy answer to question' do
        params = { question_id: question.id, id: answer.id}
        expect { delete :destroy, params: params }.to_not change(Answer, :count)
      end

      it 'redirect to question' do
        delete :destroy, params: { id: answer }
        expect(response).to redirect_to answer.question
      end
    end
  end
end
