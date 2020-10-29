class AddAverageReviewsTweetIdToFootballScores < ActiveRecord::Migration[6.0]
  def change
    add_column :football_scores, :average_reviews, :boolean, default: false
    add_column :football_scores, :average_reviews_tweet_id, :string
  end
end
