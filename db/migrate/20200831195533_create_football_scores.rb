class CreateFootballScores < ActiveRecord::Migration[6.0]
  def change
    create_table :football_scores do |t|
      t.string :home_team_name
      t.string :away_team_name
      t.integer :home_team_id
      t.integer :away_team_id
      t.integer :home_team_fulltime_score
      t.integer :away_team_fulltime_score
      t.integer :match_id
      t.integer :competition_id
      t.string :competition_name

      t.timestamps
    end
  end
end
