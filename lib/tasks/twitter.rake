desc "This task tweets"
task :tweet => :environment do

  client = Twitter::REST::Client.new do |config|
    config.consumer_key        = ENV['TWITTER_API_KEY']
    config.consumer_secret     = ENV['TWITTER_API_SECRET']
    config.access_token        = ENV['TWITTER_ACCESS_TOKEN']
    config.access_token_secret = ENV['TWITTER_ACCESS_TOKEN_SECRET']
  end

  score_tweet = client.update("testing 123")
  if score_tweet.id?
    client.update("testing api retweet option", attachment_url: "https://twitter.com/keemtaker/status/#{score_tweet.id}")
  end
end

