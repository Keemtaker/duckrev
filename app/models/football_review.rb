class FootballReview < ApplicationRecord
  belongs_to :user
  belongs_to :football_score

  validates :rating, inclusion: 1..10
  validates :content, length: { maximum: 280, too_long: "%{count} characters is the maximum allowed" }
  validates :football_score_id, uniqueness: { scope: :user_id, message: "You've reviewed this score already!" }
end
