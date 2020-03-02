class StudentsController < ApplicationController
  before_action :no_session, except: [:sign_out]

  def get_sign_up
  	@student = StudentRecord.new
  end

  def get_sign_in
    @student = StudentRecord.new
  end

  def post_sign_up
  	@student = StudentRecord.new(sign_up_params)

    if StudentLabId.exists?(lab_id: sign_up_params[:lab_id])
      if StudentLabId.find_by(lab_id: sign_up_params[:lab_id]).taken == false
        @student.name = StudentLabId.find_by(lab_id: sign_up_params[:lab_id]).name
      	if @student.save
          StudentLabId.find_by(lab_id: sign_up_params[:lab_id]).update(taken: true)
      	  flash[:notice] = "Sign Up complete! You can log in now."
      	  redirect_to students_sign_in_path and return
      	else
      	  flash[:alert] = "Unable to Sign Up, try again later."
      	  redirect_to students_sign_up_path and return
      	end
      else
        flash[:alert] = "The Lab Id is already registered."
        redirect_to students_sign_up_path and return
      end
    else
      flash[:alert] = "The Lab Id does not exists."
      redirect_to students_sign_up_path and return
    end
  end

  def post_sign_in
    if StudentRecord.exists?(lab_id: sign_in_params[:lab_id])
      if StudentRecord.find_by(lab_id: sign_in_params[:lab_id]).branch == sign_in_params[:branch]
        session[:student_user_id] = sign_in_params[:lab_id]
        session[:is_student] = true
        session[:student_branch] = sign_in_params[:branch]
        session[:student_name] = StudentRecord.find_by(lab_id: sign_in_params[:lab_id]).name
        session[:student_year] = StudentRecord.find_by(lab_id: sign_in_params[:lab_id]).year

        flash[:notice] = "You have succesfully logged in"
        redirect_to home_dashboard_path and return
      else
        flash[:alert] = "The Lab id does not belongs to that branch"
        redirect_to students_sign_in_path and return
      end
    else
      flash[:alert] = "The Lab id is not registered"
      redirect_to students_sign_in_path and return
    end
  end

  def sign_out
    session[:student_user_id] = nil
    session[:is_student] = nil
    session[:student_branch] = nil
    session[:student_name] = nil
    session[:student_year] = nil

    flash[:notice] = "Signed out successfully"
    redirect_to root_path and return 
  end

protected

  def sign_up_params
  	params.require(:student_sign_up).permit(:lab_id, :branch, :year)
  end

  def sign_in_params
    params.require(:student_sign_in).permit(:lab_id, :branch)
  end
end
