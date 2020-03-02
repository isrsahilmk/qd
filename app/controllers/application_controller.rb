class ApplicationController < ActionController::Base

  def authenticate_student!
  	if session[:student_user_id]
  	  return true
  	else
  	  flash[:alert] = "You're not authenticated."
  	  redirect_to students_sign_in_path and return
  	end
  end

  def authenticate_teacher!
  	if session[:teacher_user_id]
  	  return true
  	else
  	  flash[:alert] = "You're not authenticated."
  	  redirect_to teachers_sign_in_path and return
  	end
  end

  def authenticate_all!
  	if session[:teacher_user_id]
  	  return true
  	elsif session[:student_user_id]
  	  return true
  	else
  	  flash[:alert] = "You're not authenticated."
  	  redirect_to root_path and return
  	end
  end

  def no_session
  	if session[:student_user_id].nil? and session[:teacher_user_id].nil?
  	  return true
  	else
  	  flash[:alert] = "You're already logged in."
  	  redirect_to root_path and return
  	end
  end

end
