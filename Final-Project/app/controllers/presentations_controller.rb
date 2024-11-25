class PresentationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_presentation, only: [:show, :edit, :update, :destroy]

  def index
    @presentations = Presentation.all.order(date: :asc) # All presentations sorted by date
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
    @evaluations = @presentation.evaluations

    if current_user.teacher?
      @is_teacher = true
    elsif current_user == @presentation.user
      @is_presenter = true
    else
      @is_student = true
      @evaluation_exists = @evaluations.where(user_id: current_user.id).exists?
    end
  end

  def edit
    unless current_user.teacher? || @presentation.user == current_user
      redirect_to presentations_path, alert: "You are not authorized to edit this presentation."
    end
  end

  def update
    if @presentation.update(presentation_params)
      redirect_to presentation_path(@presentation), notice: "Presentation updated successfully."
    else
      render :edit, status: :unprocessable_entity
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

  private

  def set_presentation
    @presentation = Presentation.find(params[:id])
  end

  def presentation_params
    params.require(:presentation).permit(:title, :date, :description)
  end
  def evaluation_params
    params.require(:evaluation).permit(:score, :comment)
  end
end 