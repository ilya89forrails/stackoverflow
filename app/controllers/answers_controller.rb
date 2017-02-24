class AnswersController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]
  # before_action :set_question

  def create
    @question = Question.find(params[:question_id])
    @answer = @question.answers.new(answer_params)
    @answer.user = current_user

    if @answer.save
      redirect_to @question
      flash[:notice] = 'The answer has been successfully created.'
    else
      render :new
    end
  end

  def destroy
    @answer = Answer.find(params[:id])
    if current_user.author_of?(@answer)
      @answer.destroy
      flash[:notice] = 'The answer has been successfully deleted.'
    else
      flash[:alert] = 'You can not delete this answer.'
    end
    redirect_to @answer.question
  end

  private

  def answer_params
    params.require(:answer).permit(:body)
  end

  def set_question
    @question = Question.find(params[:question_id])
  end
end
