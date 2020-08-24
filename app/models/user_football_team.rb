class UserFootballTeam < ApplicationRecord
  belongs_to :user
  belongs_to :football_team
end
