class AddTweetReviewIdToFootballReviews < ActiveRecord::Migration[6.0]
  def change
    add_column :football_reviews, :review_tweet_id, :string
  end
end
