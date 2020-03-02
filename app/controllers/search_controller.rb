class SearchController < ApplicationController
  before_action :authenticate_all!
  
  def index
    if session[:student_user_id]
	  	if params[:search]
	  	  @results = Question.where("title LIKE ?", "%#{params[:search]}%").where(branch: session[:student_branch])
	  	else
	  	  flash[:alert] = "No search keyword entered"
	  	  redirect_to home_dashboard_path and return
	  	end
  	elsif session[:teacher_user_id]
 	  	if params[:search]
	  	  @results = Question.where("title LIKE ?", "%#{params[:search]}%").where(branch: session[:teacher_branch])
	  	else
	  	  flash[:alert] = "No search keyword entered"
	  	  redirect_to home_dashboard_path and return
	  	end
  	end	
  end

protected

end
