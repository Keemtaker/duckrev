class FootballScoresController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    @scores = FootballScore.all
  end

  def show
    @score = FootballScore.find(params[:id])
  end

end
