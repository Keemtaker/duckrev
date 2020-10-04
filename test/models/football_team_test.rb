require 'test_helper'

class FootballTeamTest < ActiveSupport::TestCase

  def setup
    @football_team = football_teams(:WestHam)
  end


  test "valid football_team" do
    assert @football_team.valid?
  end

  test "invalid football team" do
    @football_team.short_name = nil
    assert @football_team.invalid?
  end

  test "uniqueness of team api id" do
    @new_football_team = FootballTeam.new(name: "Madrid", short_name: "MAD", team_country: "Spain", team_api_id: 563)
    assert @new_football_team.invalid?
  end

end
