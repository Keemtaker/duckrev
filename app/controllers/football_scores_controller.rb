class FootballScoresController < ApplicationController
  def index
    @scores = FootballScore.all
  end

  def show
    @score = FootballScore.find(params[:id])
  end

end
