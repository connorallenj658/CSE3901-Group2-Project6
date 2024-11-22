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

    if @presentation.save
      redirect_to presentations_path, notice: "Presentation created successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @presentation = Presentation.find(params[:id]) # Fetch the presentation by ID
    @evaluations = @presentation.evaluations # Fetch all evaluations for the presentation
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
