class EvaluationsController < ApplicationController
  before_action :authenticate_user!
  def index
    @presentation = Presentation.find(params[:presentation_id])
    @evaluations = @presentation.evaluations
  end

  def new
    @presentation = Presentation.find(params[:presentation_id])
    @evaluation = @presentation.evaluations.build
  end
  before_action :authenticate_user!

  def create
    @presentation = Presentation.find(params[:presentation_id])
    @evaluation = @presentation.evaluations.new(evaluation_params)
    @evaluation.user = current_user

    if @evaluation.save
      redirect_to presentation_path(@presentation), notice: "Evaluation submitted successfully."
    else
      redirect_to presentation_path(@presentation), alert: @evaluation.errors.full_messages.to_sentence
    end
  end

  def show
    @evaluation = Evaluation.find(params[:id])
    @presentation = @evaluation.presentation # Fetch the associated presentation
  end

  private

  def evaluation_params
    params.require(:evaluation).permit(:score, :comment)
  end
end
