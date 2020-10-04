class FootballScore < ApplicationRecord
  has_many :football_reviews, dependent: :destroy

  validates :home_team_name, presence: true
  validates :away_team_name, presence: true
  validates :home_team_id, presence: true
  validates :away_team_id, presence: true
  validates :home_team_fulltime_score, presence: true
  validates :away_team_fulltime_score, presence: true
  validates :match_id, presence: true, uniqueness: true
  validates_inclusion_of :competition_id, :in => [2002, 2014, 2015, 2019, 2021], :message => "is not included in the list"
  validates :competition_name, presence: true
end
