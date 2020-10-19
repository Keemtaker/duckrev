class AddTweetScoreIdToFootballScores < ActiveRecord::Migration[6.0]
  def change
    add_column :football_scores, :score_tweet_id, :string
  end
end
