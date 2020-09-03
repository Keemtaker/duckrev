class Review < ApplicationRecord
  belongs_to :user
  belongs_to :football_score
end
