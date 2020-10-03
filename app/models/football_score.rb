class FootballScore < ApplicationRecord
  has_many :football_reviews, dependent: :destroy
end
