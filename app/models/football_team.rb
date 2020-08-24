class FootballTeam < ApplicationRecord
  has_many :user_football_teams
  has_many :users, through: :user_football_teams, dependent: :destroy
end
