class FootballTeamsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]

  def index
    @teams = FootballTeam.all
  end
end
