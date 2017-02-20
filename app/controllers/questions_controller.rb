class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_question, only: [:show, :destroy]
  
  def index
    @questions = Question.all
  end

  def show
    @answer = Answer.new
  end

  def new
    @question = Question.new
  end

  def create
    @question = Question.new(question_params)
    @question.user = current_user

    if @question.save
      redirect_to question_path(@question)
    else
      render :new
    end
  end

  def destroy
    if current_user.id == @question.user_id
      @question.destroy
      flash[:notice] ='The question has been successfully deleted.'
    else
      flash[:alert] ='You can not delete this question.'
    end
    redirect_to questions_path
  end


  private

  def set_question
    @question = Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:title, :body)
  end
end
