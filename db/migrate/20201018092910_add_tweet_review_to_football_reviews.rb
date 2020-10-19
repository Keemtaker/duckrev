class AddTweetReviewToFootballReviews < ActiveRecord::Migration[6.0]
  def change
    add_column :football_reviews, :tweet_review, :boolean, default: false
  end
end
