class FootballTeamsController < ApplicationController

  def index
    @teams = FootballTeam.all.order(:short_name)
  end

  def create
    @user = current_user
    @user.football_team = FootballTeam.find(params[:team])
    flash[:notice] = "You have chosen #{@user.football_team.short_name} as your club"
    redirect_to football_scores_path
  end
end
