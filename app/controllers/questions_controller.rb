class QuestionsController < ApplicationController
  before_action :authenticate_all!

  # def index
  #   if session[:student_user_id]
  #     @questions = Question.where(branch: session[:student_branch])
  #   else session[:teacher_user_id]
  #     @questions = Question.where(branch: session[:teacher_branch])
  #   end
  # end

  def show
    begin
      if session[:student_user_id]
        @question = Question.find(params[:id])
        if @question.branch == session[:student_branch]
          @question.increment!(:view_count, 1)
          return @question
        else
          flash[:alert] = "This question does not belongs to your branch"
          redirect_to home_dashboard_path and return
        end
      else
        @question = Question.find(params[:id])
        if @question.branch == session[:teacher_branch]
          @question.increment!(:view_count, 1)
          return @question
        else
          flash[:alert] = "This question does not belongs to your branch"
          redirect_to home_dashboard_path and return
        end
      end
    rescue ActiveRecord::RecordNotFound
      flash[:alert] = "The Question does not exists"
      redirect_to home_dashboard_path and return
    end
  end

  # def new
  #   if session[:student_user_id]
  #     @question = Question.new
  #   else
  #     flash[:alert] = "Only students can ask questions"
  #     redirect_to questions_path and return
  #   end
  # end

  def create
    if session[:student_user_id]
      @question = Question.new(new_question_params)
      @question.lab_id = session[:student_user_id]
      @question.name = session[:student_name]
      @question.branch = session[:student_branch]
      @question.student_year = session[:student_year]
      if @question.save

        TeacherRecord.where(branch: session[:student_branch]).map do |teacher|
          teacher.teacher_notifications.create(body: "A new question has been posted, Title: \"#{new_question_params[:title]}\". Please check the recently added questions and answer the question.")
        end

        flash[:notice] = "Question has been succesfully added"
        redirect_to question_path(@question) and return
      end
    else
      flash[:alert] = "Only students can ask questions"
      redirect_to home_dashboard_path and return
    end
  end

  # def edit
  #   begin
  #     if session[:student_user_id]
  #       @question = Question.find(params[:id])
  #       if @question.branch == session[:student_branch]
  #         if @question.lab_id == session[:student_user_id]
  #           return @question
  #         else
  #           flash[:alert] = "Not authorized to edit this question"
  #           redirect_to questions_path and return
  #         end
  #       else
  #         flash[:alert] = "This question does not belongs to your branch"
  #         redirect_to questions_path and return
  #       end
  #     else
  #       flash[:alert] = "Only students can edit questions"
  #       redirect_to questions_path and return
  #     end
  #   rescue ActiveRecord::RecordNotFound
  #     flash[:alert] = "The Question does not exists"
  #     redirect_to questions_path and return
  #   end
  # end

  # def update
  #   begin
  #     if session[:student_user_id]
  #       @question = Question.find(params[:id])
  #       if @question.branch == session[:student_branch]
  #         if @question.lab_id == session[:student_user_id]
  #           if @question.update(edit_question_params)
  #             flash[:notice] = "Question updated"
  #             redirect_to question_path(@question) and return
  #           end
  #         else
  #           flash[:alert] = "Not authorized to update this question"
  #           redirect_to question_path(@question) and return
  #         end
  #       else
  #         flash[:alert] = "This question does not belongs to your branch"
  #         redirect_to questions_path and return
  #       end
  #     else
  #       flash[:alert] = "Only students can edit questions"
  #       redirect_to questions_path and return
  #     end
  #   rescue ActiveRecord::RecordNotFound
  #     flash[:alert] = "The Question does not exists"
  #     redirect_to questions_path and return
  #   end
  # end

  # def destroy
  #   begin
  #     if session[:student_user_id]
  #       @question = Question.find(params[:id])
  #       if @question.branch == session[:student_branch]
  #         if @question.lab_id == session[:student_user_id]
  #           if @question.delete
  #             flash[:notice] = "Question has been deleted succesfully"
  #             redirect_to questions_path and return
  #           end
  #         else
  #           flash[:alert] = "Not authorized to update this question"
  #           redirect_to question_path(@question) and return
  #         end
  #       else
  #         flash[:alert] = "This question does not belongs to your branch"
  #         redirect_to questions_path and return  
  #       end
  #     else
  #       flash[:alert] = "Only students can delete questions"
  #       redirect_to questions_path and return
  #     end
  #   rescue ActiveRecord::RecordNotFound
  #     flash[:alert] = "The Question does not exists"
  #     redirect_to questions_path and return
  #   end
  # end

protected

  def new_question_params
    params.require(:new_question).permit(:title, :body)
  end

  # def edit_question_params
  #   params.require(:edit_question).permit(:title, :body)
  # end

end
