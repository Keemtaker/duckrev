class FootballScoresController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    @search = FootballScore.ransack(params[:q])
    @scores = @search.result(distinct: true).order("id DESC")
  end

  def show
    @user = current_user
    @score = FootballScore.find(params[:id])
  end

end
