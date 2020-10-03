class FootballReview < ApplicationRecord
  belongs_to :user
  belongs_to :football_score

  validates :football_score_id, uniqueness: { scope: :user_id, message: "You've reviewed this score already!" }
end
