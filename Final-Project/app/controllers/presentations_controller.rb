class PresentationsController < ApplicationController
  def index
    @presentations = Presentation.all
  end

  def show
    @presentation = Presentation.find(params[:id])
    @evaluations = @presentation.evaluations
  end

  def new
    @presentation = Presentation.new
  end

  def create
    @presentation = Presentation.new(presentation_params)
    if @presentation.save
      redirect_to @presentation, notice: "Presentation created successfully!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def presentation_params
    params.require(:presentation).permit(:title, :date)
  end
end