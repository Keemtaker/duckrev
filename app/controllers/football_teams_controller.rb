class FootballTeamsController < ApplicationController

  def index
    @teams = FootballTeam.all.order(:short_name)
  end

  def create
    @user = current_user
    @user.football_team = FootballTeam.find(params[:team])
  end
end
