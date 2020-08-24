class AddTeamCountryToFootballTeams < ActiveRecord::Migration[6.0]
  def change
    add_column :football_teams, :team_country, :string
  end
end
