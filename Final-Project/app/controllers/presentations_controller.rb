class PresentationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_presentation, only: [:show, :edit, :update, :destroy]
  before_action :set_course

  def index
    @presentations = Presentation.all.order(date: :asc) # All presentations sorted by date
  end

  def new
    @presentation = Presentation.new
  end

  def create
    user = User.find_by(email: params[:presentation][:user_email])
    
    if user.nil?
      redirect_to new_course_presentation_path(@course.id)
      flash[:alert] = "User does not exist"
      return
    end
    if !@course.users.exists?(user.id)
      redirect_to new_course_presentation_path(@course.id)
      flash[:alert] = "User is not enrolled in course"
      return
    end

    date_parts = [params[:presentation]["date(1i)"], params[:presentation]["date(2i)"], params[:presentation]["date(3i)"]]
    combined_date = Date.new(*date_parts.map(&:to_i))

    @presentation = Presentation.new(user_id: user.id, title: params[:presentation][:title], description: params[:presentation][:description], date: combined_date)
    @presentation.course_id = @course.id

    # Prevent duplicate evaluations logic is not relevant here for creating presentations
    if @presentation.save
      redirect_to course_presentations_path(@course), notice: "Presentation created successfully."
    else
      flash[:alert] = @presentation.errors.full_messages.join(", ")
      puts @presentation.errors.full_messages.join(", ")
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @evaluations = @presentation.evaluations

    if current_user.teacher?
      @is_teacher = true
      @evaluation_exists = @evaluations.where(user_id: current_user.id).exists?
    elsif current_user == @presentation.user
      @is_presenter = true
    else
      @is_student = true
      @evaluation_exists = @evaluations.where(user_id: current_user.id).exists?
    end
  end

  def edit
    unless current_user.teacher? || @presentation.user == current_user
      redirect_to course_presentations_path(@course), alert: "You are not authorized to edit this presentation."
    end
  end

  def update
    if @presentation.update(presentation_params)
      redirect_to course_presentations_path(@course), notice: "Presentation updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if current_user.teacher? || @presentation.user == current_user
      @presentation.destroy
      redirect_to course_presentations_path(@course), notice: "Presentation deleted successfully."
    else
      redirect_to course_presentations_path(@course), alert: "You are not authorized to delete this presentation."
    end
  end

  # Add edit functionality as required
  def edit
    if @presentation.user != current_user && !current_user.teacher?
      redirect_to course_presentations_path(@course), alert: "You are not authorized to edit this presentation."
    end
  end

  def update
    if @presentation.update(presentation_params)
      redirect_to course_presentations_path(@course), notice: "Presentation updated successfully."
    else
      render 'edit', status: :unprocessable_entity
    end
  end

  private

  def set_presentation
    @presentation = Presentation.find(params[:id])
  end

  def presentation_params
    params.require(:presentation).permit(:title, :date, :description, :course_id, :user_id, :user_email)
  end

  def set_course
    @course = Course.find(params[:course_id]) if params[:course_id].present?
  rescue ActiveRecord::RecordNotFound
    flash[:error] = "Course not found."
    redirect_to courses_path
  end

  def evaluation_params
    params.require(:evaluation).permit(:score, :comment)
  end
end 