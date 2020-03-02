class NotificationController < ApplicationController
  before_action :authenticate_teacher!

  def index
  	TeacherRecord.find_by(lab_id: session[:teacher_user_id]).teacher_notifications.update_all(read: true)
  	return @notifications = TeacherRecord.find_by(lab_id: session[:teacher_user_id]).teacher_notifications
  end
end
