class EditCompetitionIdOnFootballTeams < ActiveRecord::Migration[6.0]
  def change
    remove_index :football_teams, :competition_id
    add_index :football_teams, :competition_id
  end
end
