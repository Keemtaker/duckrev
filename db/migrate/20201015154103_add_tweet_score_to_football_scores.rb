class AddTweetScoreToFootballScores < ActiveRecord::Migration[6.0]
  def change
    add_column :football_scores, :tweet_score, :boolean, default: false
  end
end
