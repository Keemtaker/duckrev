class RemoveSelectedColumnsOnFootballTeams < ActiveRecord::Migration[6.0]
  def change
    remove_column :football_teams, :competition_id
    remove_column :football_teams, :competition_name
    remove_column :football_teams, :competition_country
  end
end
