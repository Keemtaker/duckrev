class FootballTeam < ApplicationRecord
  has_many :user_football_teams, dependent: :destroy
  has_many :users, through: :user_football_teams, dependent: :destroy

  validates :name, presence: true
  validates :short_name, presence: true
  validates :team_country, presence: true
  validates :team_api_id, presence: true, uniqueness: true
end
