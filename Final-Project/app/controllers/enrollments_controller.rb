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
      #redirect_to courses_path  
    end
  end

  def create
    user = nil
    if params[:user_email]
      user = User.find_by(email: params[:user_email])
    elsif params[:user_id]
      user = User.find_by(id: params[:user_id])
    end
    if user.nil?
      redirect_to course_path(params[:course_id]), alert: "User not found"
      return
    end
    @enrollment = Enrollment.new(enrollment_params)
    if @enrollment.save
      #flash[:success] = "Hello and Welcome"
      redirect_to course_path(@enrollment.course_id), notice: "Student enrolled"
    else
      redirect_to course_path(@enrollment.course_id), notice: "Student could not be enrolled"
    end
  end

  def destroy
    @enrollment = Enrollment.find_by(user_id: params[:user_id], course_id: params[:course_id])
    if @enrollment.nil?
      redirect_to courses_path, alert: 'Enrollment not found.'
    else
      @enrollment.destroy
      redirect_to courses_path, notice: 'Enrollment successfully deleted.'
    end
  end
    
  private
    
  def enrollment_params
    params.permit(:user_id, :course_id)
    #params.require(:enrollment).permit(:user_id, :course_id, :user_email)
  end
end
