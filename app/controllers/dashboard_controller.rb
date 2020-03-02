class DashboardController < ApplicationController
  before_action :authenticate_all!
  
  def index
    if session[:student_user_id]
      @questions = Question.where(branch: session[:student_branch])
    else session[:teacher_user_id]
      @questions = Question.where(branch: session[:teacher_branch])
    end
  end
end
