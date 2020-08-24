class CreateFootballTeams < ActiveRecord::Migration[6.0]
  def change
    create_table :football_teams do |t|
      t.string :name
      t.integer :team_api_id
      t.string :short_name
      t.integer :competition_id
      t.string :competition_name
      t.string :competition_country

      t.timestamps
    end
    add_index :football_teams, :team_api_id, unique: true
    add_index :football_teams, :competition_id, unique: true
  end
end
