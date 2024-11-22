class EvaluationsController < ApplicationController
  def index
    @presentation = Presentation.find(params[:presentation_id])
    @evaluations = @presentation.evaluations
  end

  def new
    @presentation = Presentation.find(params[:presentation_id])
    @evaluation = @presentation.evaluations.build
  end

  def create
    @presentation = Presentation.find(params[:presentation_id])
    @evaluation = @presentation.evaluations.build(evaluation_params)
    if @evaluation.save
      redirect_to presentation_path(@presentation), notice: "Evaluation added successfully!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def evaluation_params
    params.require(:evaluation).permit(:score, :comment)
  end
end
