class FootballScore < ApplicationRecord
  after_validation :set_slug, only: [:create, :update]
  after_create :football_score_tweet
  after_update_commit :generate_average_reviews


  has_many :football_reviews, dependent: :destroy

  validates :home_team_name, presence: true
  validates :away_team_name, presence: true
  validates :home_team_id, presence: true
  validates :away_team_id, presence: true
  validates :home_team_fulltime_score, presence: true
  validates :away_team_fulltime_score, presence: true
  validates :match_id, presence: true, uniqueness: true
  validates_inclusion_of :competition_id, :in => [2001, 2002, 2014, 2015, 2019, 2021], :message => "is not included in the list"
  validates :competition_name, presence: true




  def to_param
    "#{id}-#{slug}"
  end

  private

  def generate_average_reviews
    if (self.archived_state) && (!self.average_reviews)
      if self.football_reviews.size >= 3
        review_url = Rails.application.routes.url_helpers.football_score_url(self, :host => ENV['WEB_URL'])
        application_twitter_username = ENV['TWITTER_USERNAME']
        tweet_url =  "https://twitter.com/#{application_twitter_username}/status/#{self.score_tweet_id}"
        home_and_away_ids = [self.home_team_id, self.away_team_id]
        neutral_reviews = []
        home_reviews = []
        away_reviews = []

        self.football_reviews.each do | review |
          if (review.user.football_team.nil?) || (!home_and_away_ids.include? review.user.football_team.team_api_id)
            neutral_reviews << review.rating
          elsif
            (!review.user.football_team.nil?) && (review.user.football_team.team_api_id == self.home_team_id)
            home_reviews << review.rating
          elsif
            (!review.user.football_team.nil?) && (review.user.football_team.team_api_id == self.away_team_id)
            away_reviews << review.rating
          end
        end

        if neutral_reviews.size >=  1
          neutral_reviews_average = neutral_reviews.inject{ |sum, el| sum + el }.to_f / neutral_reviews.size
          neutral_reviews_stats_tweet = "#{neutral_reviews_average.round(1)}⭐️ average for neutral fans"
        else
          neutral_reviews_stats_tweet = ""
        end

        if home_reviews.size >=  1
          home_reviews_average = home_reviews.inject{ |sum, el| sum + el }.to_f / home_reviews.size
          home_reviews_stats_tweet = "#{home_reviews_average.round(1)}⭐️ average for #{self.home_team_name} fans"
        else
          home_reviews_stats_tweet = ""
        end

        if away_reviews.size >=  1
          away_reviews_average = away_reviews.inject{ |sum, el| sum + el }.to_f / away_reviews.size
          away_reviews_stats_tweet = "#{away_reviews_average.round(1)}⭐️ average for #{self.away_team_name} fans"
        else
          away_reviews_stats_tweet = ""
        end

        tweet_response = $client.update("Game review report.\n" + neutral_reviews_stats_tweet + "\n" + home_reviews_stats_tweet + "\n" + away_reviews_stats_tweet + "\n" + "Reviews at #{review_url}", attachment_url: tweet_url)
        if tweet_response.id?
          self.update(average_reviews: true)
          self.update(average_reviews_tweet_id: tweet_response.id)
        end
      end
    end
  end

  def football_score_tweet
    if !self.tweet_score?
      review_url = Rails.application.routes.url_helpers.football_score_url(self, :host => ENV['WEB_URL'])
      tweet_response = $client.update("#{self.home_team_name}: #{self.home_team_fulltime_score}\n#{self.away_team_name}: #{self.away_team_fulltime_score}\n\nReview the game at #{review_url}\n#{twitter_hashtag}")
      if tweet_response.id?
        self.update(tweet_score: true)
        self.update(score_tweet_id: tweet_response.id)
      end
    end
  end

  def twitter_hashtag
    if ENV['WEB_URL'] == "https://duckrev.com"
      case self.competition_name
      when "Premier League"
        '#PremierLeague #EPL #PL'
      when "Primera Division"
        '#LaLiga #Football'
      when "UEFA Champions League"
        '#ChampionsLeague #UEFA'
      when "Bundesliga"
        '#Bundesliga #Football'
      when "Serie A"
        '#SerieA #Football'
      when "Ligue 1"
        '#Ligue1 #Football'
      end
    end
  end

  def set_slug
    self.slug = "#{home_team_name} vs #{away_team_name}".to_s.parameterize
  end

end
