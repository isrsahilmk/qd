class AnswersController < ApplicationController
  before_action :authenticate_all!

  # def index
  # end

  # def show
  # end

  # def new
  # end

  def create
    @question = Question.find(params[:question_id])
    @answer = @question.answers.new(new_question_answer_params)
    if session[:student_user_id]
      if @question.branch == session[:student_branch]
        @answer.lab_id = session[:student_user_id]
        @answer.name = session[:student_name]

        if @answer.save
          flash[:notice] = "Your answer has been added"
          redirect_to question_path(@question) and return
        else
        flash[:alert] = "Unable to save the answer"
        redirect_to question_path(@question) and return          
        end
      else
        flash[:alert] = "Question does not belong to your branch"
        redirect_to question_path(@question) and return
      end
    elsif session[:teacher_user_id]
      if @question.branch == session[:teacher_branch]
      @answer.lab_id = session[:teacher_user_id]
      @answer.name = session[:teacher_name]

      if @answer.save
        flash[:notice] = "Your answer has been added"
        redirect_to question_path(@question) and return
      else
        flash[:alert] = "Unable to save the answer"
        redirect_to question_path(@question) and return
      end
      else
        flash[:alert] = "Question does not belong to your branch"
        redirect_to question_path(@question) and return
      end
    end
  end

  # def edit
  # end

  # def update
  # end

  # def destroy
  # end

protected

  def new_question_answer_params
    params.require(:new_answer).permit(:short_answer, :descriptive_answer)
  end

  # def edit_question_params
  #   params.require(:edit_answer).permit(:short_answer, :descriptive_answer)
  # end
end
