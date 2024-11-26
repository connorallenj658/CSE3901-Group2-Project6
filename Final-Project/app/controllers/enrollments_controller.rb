class EnrollmentsController < ApplicationController
  def index
    @enrollments = Enrollment.all
  end
    
  def new
    @enrollment = Enrollment.new
  end

  def show
    @enrollment = Enrollment.find_by_id(params[:id])  
    if @enrollment.nil?
      flash[:alert] = 'Enrollment not found.'
    end
  end

  def create
    user = User.find_by(email: params[:user_email])
    
    if user.nil?
      redirect_to course_path(params[:course_id]), alert: "User not found"
      return
    end
    @enrollment = Enrollment.new(user_id: user.id, course_id: params[:course_id])
    if @enrollment.save
      redirect_to course_roster_path(params[:course_id]), notice: "Student enrolled"
    else
      redirect_to course_roster_path(params[:course_id]), alert: "Student could not be enrolled"
    end
  end

  def destroy
    @enrollment = Enrollment.find_by(user_id: params[:user_id], course_id: params[:course_id])
    if @enrollment.nil?
      redirect_to course_roster_path(params[:course_id]), alert: 'Enrollment not found.'
    else
      @enrollment.destroy
      redirect_to course_roster_path(params[:course_id]), notice: 'Enrollment successfully deleted.'
    end
  end
    
  private
    
  def enrollment_params
    params.permit(:user_id, :course_id, :user_email)
  end
end