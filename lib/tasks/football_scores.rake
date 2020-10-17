require 'httparty'

base_uri = ENV['BASE_URI']
sports_token_key = ENV['SPORTS_TOKEN_KEY']
sports_token_value = ENV['SPORTS_TOKEN_VALUE']

desc "This task retrieves football scores api data"
task :footie_scores_data => :environment do
  FootballScore.destroy_all
  competition_ids = ["2002", "2014", "2015", "2019", "2021"]
  competition_ids.each do | competition_id |
    response = HTTParty.get("#{base_uri}/competitions/#{competition_id}/matches?status=FINISHED&dateFrom=2020-08-28&dateTo=2020-08-28", :headers => { "#{sports_token_key}" => "#{sports_token_value}"}).parsed_response
    response["matches"].each do |score|
      puts "creating football scores #{score["homeTeam"]["name"]}"
      puts "-----------------------"
      FootballScore.create(home_team_name: score["homeTeam"]["name"], away_team_name: score["awayTeam"]["name"], home_team_id: score["homeTeam"]["id"],
                            away_team_id: score["awayTeam"]["id"], home_team_fulltime_score: score["score"]["fullTime"]["homeTeam"],
                            away_team_fulltime_score: score["score"]["fullTime"]["awayTeam"], match_id: score["id"], competition_id: response["competition"]["id"],
                            competition_name: response["competition"]["name"])
    end
  end
end



