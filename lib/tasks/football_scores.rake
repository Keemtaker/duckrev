require 'httparty'

base_uri = ENV['BASE_URI']
sports_token_key = ENV['SPORTS_TOKEN_KEY']
sports_token_value = ENV['SPORTS_TOKEN_VALUE']
scores_date = Time.now.strftime('%Y-%m-%d')

desc "This task retrieves football scores api data"
task :football_scores_data => :environment do
  competition_ids = ["2001", "2002", "2014", "2015", "2019", "2021"]
  competition_ids.each do | competition_id |
    response = HTTParty.get("#{base_uri}/competitions/#{competition_id}/matches?status=FINISHED&dateFrom=#{scores_date}&dateTo=#{scores_date}", :headers => { "#{sports_token_key}" => "#{sports_token_value}"}).parsed_response
    if response["matches"].present?
      response["matches"].each do |score|
        FootballScore.create(home_team_name: score["homeTeam"]["name"], away_team_name: score["awayTeam"]["name"], home_team_id: score["homeTeam"]["id"],
                              away_team_id: score["awayTeam"]["id"], home_team_fulltime_score: score["score"]["fullTime"]["homeTeam"],
                              away_team_fulltime_score: score["score"]["fullTime"]["awayTeam"], match_id: score["id"], competition_id: response["competition"]["id"],
                              competition_name: response["competition"]["name"])
      end
    end
  end
end
