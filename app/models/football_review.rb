class FootballReview < ApplicationRecord
  after_create :football_review_tweet

  belongs_to :user
  belongs_to :football_score

  validates :rating, presence: true, inclusion: 1..10
  validates :content, presence: true, length: { maximum: 280, too_long: "%{count} characters is the maximum allowed" }
  validates :football_score_id, uniqueness: { scope: :user_id, message: "You've reviewed this score already!" }

  def decrypt_field(value)
    EncryptionService.decrypt(value)
  end

  def football_review_tweet
    if !self.tweet_review?
      $review_client.access_token.replace self.decrypt_field(self.user.access_token)
      $review_client.access_token_secret.replace self.decrypt_field(self.user.access_secret)

      tweet_response = $review_client.update("⭐️ #{self.rating}/10\n#{self.content}", attachment_url: "https://twitter.com/#{self.user.username}/status/#{self.football_score.score_tweet_id}")
      if tweet_response.id?
        self.update(tweet_review: true)
        self.update(review_tweet_id: tweet_response.id)
      end
    end
  end
end
