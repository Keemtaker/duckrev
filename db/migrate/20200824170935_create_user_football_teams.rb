class CreateUserFootballTeams < ActiveRecord::Migration[6.0]
  def change
    create_table :user_football_teams do |t|
      t.references :user, null: false, foreign_key: true
      t.references :football_team, null: false, foreign_key: true

      t.timestamps
    end
  end
end
