class FootballScore < ApplicationRecord
  has_many :reviews, dependent: :destroy
end
