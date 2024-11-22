<<<<<<< HEAD
class CoursesController < ApplicationController
  def index
    @Courses = Course.all
  end

  def new
    @courses = Course.new
  end
  
  def show
    @courses=Course.find_by_id(params[:id])
    #debugger
    if @courses.nil?
      flash[:alert] = 'Course not found.'
      #redirect_to users_path
    end
    #puts "<-----------------name--------------->#{@user['name']}"
    #puts "<-----------------email--------------->#{@user['email']}"
  end
  
  def create
    @courses = Course.new(course_params)
    if @courses.save
      flash[:success] = "Hello and welcome!"
      redirect_to user_path(@courses), notice: "Course was successfully created!"
    else
      render 'new', status: :unprocessable_entity
    end
  end
  
  def edit
    @courses = Course.find(params[:id])
  end
  
  def updated
    @courses = Course.find(params[:id])
    if @courses.update(course_params)
      redirect_to @courses, notice: 'Course was successfully updated'
    else
      render 'edit', status: :unprocessable_entity
    end
  end
  
  def destroy
    @courses = Course.find(params[:id])
    @courses.destroy
  end
  
  private
  def course_params
    params.require(:user).permit(:teacher, :students)
  end
end
=======
class CoursesController < ApplicationController
  def index
    @Courses = Course.all
  end

  def new
    @courses = Course.new
  end
  
  def show
    @courses=Course.find_by_id(params[:id])
    #debugger
    if @courses.nil?
      flash[:alert] = 'Course not found.'
      #redirect_to users_path
    end
    #puts "<-----------------name--------------->#{@user['name']}"
    #puts "<-----------------email--------------->#{@user['email']}"
  end
  
  def create
    @courses = Course.new(user_params)
    if @courses.save
      flash[:success] = "Hello and welcome!"
      redirect_to user_path(@courses), notice: "Course was successfully created!"
    else
      render 'new', status: :unprocessable_entity
    end
  end
  
  def edit
    @courses = Course.find(params[:id])
  end
  
  def updated
    @courses = Course.find(params[:id])
    if @courses.update(course_params)
      redirect_to @courses, notice: 'Course was successfully updated'
    else
      render 'edit', status: :unprocessable_entity
    end
  end
  
  def destroy
    @courses = Course.find(params[:id])
    @courses.destroy
  end
  
  private
  def course_params
    params.require(:user).permit(:teacher, :students)
  end
end
>>>>>>> 0114c93664b4e9c65063d6f0c2cdeee86c0f763b
  