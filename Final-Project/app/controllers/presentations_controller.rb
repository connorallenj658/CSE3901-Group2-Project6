class PresentationsController < ApplicationController
  before_action :authenticate_user! # Ensure users are logged in
  before_action :set_course

  def index
    @presentations = Presentation.all.order(date: :asc) # Fetch all presentations sorted by date
  end

  def new
    @presentation = Presentation.new
  end

  def create
    @presentation = Presentation.new(presentation_params)
    @presentation.user = current_user # Associate the presentation with the logged-in user
    @presentation.course = @course

    # Prevent duplicate evaluations logic is not relevant here for creating presentations
    if @presentation.save
      redirect_to course_presentations_path(@course), notice: "Presentation created successfully."
    else
      flash[:alert] = @presentation.errors.full_messages.join(", ")
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @presentation = Presentation.find(params[:id])
    @evaluations = @presentation.evaluations

    if current_user.teacher?
      # Teacher logic
      @is_teacher = true
    elsif current_user == @presentation.user
      # Presenter logic
      @is_presenter = true
    else
      # Non-presenter student logic
      @is_student = true
      # Check if the student has already evaluated this presentation
      @evaluation_exists = @evaluations.where(user_id: current_user.id).exists?
    end
  end


  def destroy
    @presentation = Presentation.find(params[:id])

    if current_user.teacher? || @presentation.user == current_user
      @presentation.destroy
      redirect_to presentations_path, notice: "Presentation deleted successfully."
    else
      redirect_to presentations_path, alert: "You are not authorized to delete this presentation."
    end
  end

  # Add edit functionality as required
  def edit
    @presentation = Presentation.find(params[:id])
    if @presentation.user != current_user && !current_user.teacher?
      redirect_to presentations_path, alert: "You are not authorized to edit this presentation."
    end
  end

  def update
    @presentation = Presentation.find(params[:id])

    if @presentation.update(presentation_params)
      redirect_to presentation_path(@presentation), notice: "Presentation updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def presentation_params
    params.require(:presentation).permit(:title, :date, :credits, :description, :course_id)
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