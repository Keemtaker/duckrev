class FootballScore < ApplicationRecord
  after_validation :set_slug, only: [:create, :update]

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

  def to_param
    "#{id}-#{slug}"
  end

  private

  def set_slug
    self.slug = "#{home_team_name} vs #{away_team_name}".to_s.parameterize
  end

end
