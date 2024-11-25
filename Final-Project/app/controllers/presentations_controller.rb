class PresentationsController < ApplicationController
  before_action :authenticate_user! # Ensure users are logged in

  def index
    @presentations = Presentation.all
  end

  def new
    @presentation = Presentation.new
  end

  def create
    @presentation = Presentation.new(presentation_params)
    @presentation.user = current_user # Associate the presentation with the logged-in user

    # Prevent duplicate evaluations logic is not relevant here for creating presentations
    if @presentation.save
      redirect_to presentations_path, notice: "Presentation created successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

private

def evaluation_params
  params.require(:evaluation).permit(:score, :comment)
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
    if @presentation.user == current_user # Only allow the owner to delete
      @presentation.destroy
      redirect_to presentations_path, notice: "Presentation deleted successfully."
    else
      redirect_to presentations_path, alert: "You are not authorized to delete this presentation."
    end
  end

  private

  def presentation_params
    params.require(:presentation).permit(:title, :date, :description)
  end
end
