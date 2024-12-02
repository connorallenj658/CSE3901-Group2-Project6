class EvaluationsController < ApplicationController
  before_action :authenticate_user!


  def index
    @presentation = Presentation.find(params[:presentation_id])
    @evaluations = @presentation.evaluations
  end

  def new
    @presentation = Presentation.includes(:evaluations => :user).find(params[:presentation_id])
    @evaluation = @presentation.evaluations.build
  end
  before_action :authenticate_user!

  def create
    @presentation = Presentation.find(params[:presentation_id])

    @evaluation = @presentation.evaluations.new(evaluation_params)
    @evaluation.user = current_user

    if @evaluation.save
      redirect_to course_presentation_path(@presentation.course, @presentation), notice: "Evaluation submitted successfully."
    else
      redirect_to course_presentation_path(@presentation.course, @presentation), alert: @evaluation.errors.full_messages.to_sentence
    end
  end

  def show
    @evaluation = Evaluation.find(params[:id])
    @presentation = @evaluation.presentation # Fetch the associated presentation
  end

  def destroy
    @evaluation = Evaluation.find(params[:id])
    @course = Course.find(params[:course_id])
    @presentation = Presentation.find(params[:presentation_id])
    if current_user.teacher?
      @evaluation.destroy
      redirect_to course_presentation_path(@course, @presentation), notice: "Presentation deleted successfully."
    else
      redirect_to course_presentation_path(@course, @presentation), alert: "You are not authorized to delete this presentation."
    end
  end

  private

  def evaluation_params
    params.permit(:score, :comment)
  end
end
