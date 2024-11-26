class CoursesController < ApplicationController
  before_action :authenticate_user!

  def index
    @courses = Course.all  
  end

  def new
    @course = Course.new  
  end
  
  def show
    @course = Course.find_by_id(params[:id])  
    if @course.nil?
      flash[:alert] = 'Course not found.'
      #redirect_to courses_path  
    end
  end

  def roster
    @course = Course.find_by_id(params[:id])
    if @course.nil?
      flash[:alert] = 'Course not found.'
      redirect_to courses_path
    else
      @users = @course.users
      if @users.nil? || @users.empty?
        flash[:notice] = 'No students enrolled in this course.'
      end
    end
  end
  
  
  def create
    @course = Course.new(course_params)  
    @course.user = current_user
    if @course.save
      @enrollment = Enrollment.new(user_id: current_user.id, course_id: @course.id)
      @enrollment.save
      #flash[:success] = "Hello and Welcome"
      redirect_to course_path(@course), notice: "Course was successfully created!"
    else
      render 'new', status: :unprocessable_entity
    end
  end
  
  def edit
    @course = Course.find(params[:id])
  end
  
  def update 
    @course = Course.find(params[:id])
    if @course.update(course_params)
      redirect_to @course, notice: 'Course was successfully updated'
    else
      render 'edit', status: :unprocessable_entity
    end
  end
  
  def destroy
    @course = Course.find(params[:id])
    @course.destroy
    redirect_to courses_path, notice: 'Course was successfully deleted'
  end
  
  private
  
  def course_params
    params.require(:course).permit(:name, :description, :credits) 
  end
end