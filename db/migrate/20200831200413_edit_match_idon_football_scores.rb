class EditMatchIdonFootballScores < ActiveRecord::Migration[6.0]
  def change
    # remove_index :football_scores, :match_id
    add_index :football_scores, :match_id, unique: true
  end
end
