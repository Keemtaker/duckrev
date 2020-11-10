class FootballReview < ApplicationRecord
  after_create :football_review_tweet if !Rails.env.test?

  belongs_to :user
  belongs_to :football_score

  validates :rating, presence: true, inclusion: 1..10
  validates :content, presence: true, length: { maximum: 270, too_long: "%{count} characters is the maximum allowed" }
  validates :football_score_id, uniqueness: { scope: :user_id, message: "You've reviewed this score already!" }
  validates :recent_score, presence: { message: "This score is archived and can no longer be reviewed" }

  def recent_score
   return true if !self.football_score.archived_state
  end

  def decrypt_field(value)
    EncryptionService.decrypt(value)
  end

  def football_review_tweet
    if !self.tweet_review?
      $review_client.access_token.replace self.decrypt_field(self.user.access_token)
      $review_client.access_token_secret.replace self.decrypt_field(self.user.access_secret)

      application_twitter_username = ENV['TWITTER_USERNAME']
      tweet_url = "https://twitter.com/#{application_twitter_username}/status/#{self.football_score.score_tweet_id}"

      tweet_response = $review_client.update("⭐️ #{self.rating}/10\n#{self.content}", attachment_url: tweet_url)
      if tweet_response.id?
        self.update(tweet_review: true)
        self.update(review_tweet_id: tweet_response.id)
      end
    end
  end
end
