require 'httparty'

base_uri = ENV['BASE_URI']
sports_token_key = ENV['SPORTS_TOKEN_KEY']
sports_token_value = ENV['SPORTS_TOKEN_VALUE']

desc "This task retrieves teams api data"
task :footie_teams_data => :environment do
  competition_ids = ["2002", "2014", "2015", "2019", "2021"]
  competition_array = []

  competition_ids.each do | competition_id |
    response = HTTParty.get("#{base_uri}/competitions/#{competition_id}/teams", :headers => { "#{sports_token_key}" => "#{sports_token_value}"}).parsed_response
    competition_array << response["teams"]
  end

  FootballTeam.destroy_all

  competition_array.each do | team_array |
    team_array.each do | team |
      puts "creating football team #{team["name"]}"
      puts "-----------"
      FootballTeam.create(name: team["name"], team_api_id: team["id"], short_name: team["shortName"], team_country: team["area"]["name"])
      puts "-----------"
      puts "created"
    end
  end
end
