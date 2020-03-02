class TeachersController < ApplicationController
  before_action :no_session, except: [:sign_out]

  def get_sign_up
  	@teacher = TeacherRecord.new
  end

  def get_sign_in
    @teacher = TeacherRecord.new
  end

  def post_sign_up
    @teacher = TeacherRecord.new(sign_up_params)

    if TeacherLabId.exists?(lab_id: sign_up_params[:lab_id])
      if TeacherLabId.find_by(lab_id: sign_up_params[:lab_id]).taken == false
        @teacher.name = TeacherLabId.find_by(lab_id: sign_up_params[:lab_id]).name
        if @teacher.save
          TeacherLabId.find_by(lab_id: sign_up_params[:lab_id]).update(taken: true)
          flash[:notice] = "Sign Up complete! You can log in now."
          redirect_to teachers_sign_in_path and return
        else
          flash[:alert] = "Unable to Sign Up, try again later."
          redirect_to teachers_sign_up_path and return
        end
      else
        flash[:alert] = "The Lab Id is already registered."
        redirect_to teachers_sign_up_path and return
      end
    else
      flash[:alert] = "The Lab Id does not exists."
      redirect_to teachers_sign_up_path and return
    end
  end

  def post_sign_in
    if TeacherRecord.exists?(lab_id: sign_in_params[:lab_id])
      if TeacherRecord.find_by(lab_id: sign_in_params[:lab_id]).branch == sign_in_params[:branch]
        session[:teacher_user_id] = sign_in_params[:lab_id]
        session[:is_teacher] = true
        session[:teacher_branch] = sign_in_params[:branch]
        session[:teacher_name] = TeacherRecord.find_by(lab_id: sign_in_params[:lab_id]).name

        flash[:notice] = "You have succesfully logged in"
        redirect_to home_dashboard_path and return
      else
        flash[:alert] = "The Lab id does not belongs to that branch"
        redirect_to teachers_sign_in_path and return
      end
    else
      flash[:alert] = "The Lab id is not registered"
      redirect_to teachers_sign_in_path and return
    end
  end

  def sign_out
    session[:teacher_user_id] = nil
    session[:is_teacher] = nil
    session[:teacher_branch] = nil
    session[:teacher_name] = nil

    flash[:notice] = "Signed out successfully"
    redirect_to root_path and return 
  end

  protected

  def sign_up_params
  	params.require(:teacher_sign_up).permit(:lab_id, :branch)
  end

  def sign_in_params
    params.require(:teacher_sign_in).permit(:lab_id, :branch)
  end
end
