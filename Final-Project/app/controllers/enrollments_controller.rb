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

  def create
    @enrollment = Enrollment.new(enrollment_params)
    if @enrollment.save
      #flash[:success] = "Hello and Welcome"
      redirect_to course_path(@enrollment.course_id), notice: "Student enrolled"
    else
      render 'new', status: :unprocessable_entity
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
    params.require(:enrollment).permit(:user_id, :course_id)
  end
end
