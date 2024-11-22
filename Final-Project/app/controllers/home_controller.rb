class HomeController < ApplicationController
  before_action :authenticate_user!

  def index
    if current_user.teacher?
      # Teachers see all presentations
      @presentations = Presentation.all
    else
      # Students see presentations they haven't evaluated
      @presentations = Presentation.joins(:evaluations).where.not(evaluations: { user_id: current_user.id })
    end
  end
end
