# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


User.destroy_all
FootballReview.destroy_all

puts "Creating users"
user_list = [
  {username: "Keem", uid: "123", provider: "twitter", password: "123456", email: nil, access_token: "1289ih", access_secret: "fghkldkns"},
  {username: "Ronaldo", uid: "214", provider: "twitter", password: "123457", email: nil, access_token: "1289ih", access_secret: "fghkldkns"},
  {username: "Ozil", uid: "222", provider: "twitter", password: "123455", email: nil, access_token: "1289ih", access_secret: "fghkldkns"},
  {username: "Kaka", uid: "12", provider: "twitter", password: "123453", email: nil, access_token: "1289ih", access_secret: "fghkldkns"},
  {username: "Messi", uid: "345", provider: "twitter", password: "143456", email: nil, access_token: "1289ih", access_secret: "fghkldkns"},
  {username: "Iniesta", uid: "145", provider: "twitter", password: "153456", email: nil, access_token: "1289ih", access_secret: "fghkldkns"},
  {username: "Zidane", uid: "347", provider: "twitter", password: "127456", email: nil, access_token: "1289ih", access_secret: "fghkldkns"},
]

User.create!(user_list)

User.all.each do | user |
  user.football_team = FootballTeam.all.sample
end


review_one = "VAR didn’t give the decision. VAR provides the referee with an opportunity to make a more informed decision. And it’s worked brilliantly so far this season. We should vent our frustration at the people who bring these ridiculous rules in. It’s the rule that’s the problem, not VAR"
review_two = "Barca paid Liverpool £150M for Coutinho that was used to assemble a team that knocked them out of the CL last season. Then sent Coutinho to Bayern to knock Barcelona out of the CL again this season and now they have to pay another £5M to Liverpool. Talk about poor life choices"
review_three = "Guardiola's career has had a strange second act. He's like a world-class novelist who emerges with a debut that changes the landscape; but who never quite writes a book of that brilliance again, despite several manifestations of genius in the years since."
review_four = "I did not think another footballer could hit 100 international goals in my lifetime. And I certainly didn’t think it would be Ronaldo to do it (if anyone did it) when he emerged, a flamboyant lad with earrings who just wanted to dribble. This sport."
review_five = "4 champions league titles in 5 years. That is insane. No wonder Madrid fans were simply nonchalant during these champions league title anniversaries whiles other fans were all over the place with excitement"
review_six = "Luis Suarez is a volatile player in possession. Everything he does is instinctive. More often than not, it comes off because he’s faster in execution than you are at preparing for it. It almost never feels like he plans anything."


review_list = [
  {rating: 8, content: review_one, user_id: User.find_by(username: "Keem").id, football_score_id: FootballScore.last.id},
  {rating: 4, content: review_two, user_id: User.find_by(username: "Ronaldo").id, football_score_id: FootballScore.last.id},
  {rating: 7, content: review_three, user_id: User.find_by(username: "Ozil").id, football_score_id: FootballScore.last.id},
  {rating: 9, content: review_four, user_id: User.find_by(username: "Messi").id, football_score_id: FootballScore.last.id},
  {rating: 2, content: review_five, user_id: User.find_by(username: "Iniesta").id, football_score_id: FootballScore.last.id},
  {rating: 5, content: review_six, user_id: User.find_by(username: "Zidane").id, football_score_id: FootballScore.last.id},
]

FootballReview.create!(review_list)

puts "Done"


# FootballScore.create(home_team_name: "England", away_team_name: "Denmark", home_team_id: 899, away_team_id: 888, home_team_fulltime_score: 0, away_team_fulltime_score: 1, match_id: 20,
#                       competition_id: 2002, competition_name: "Premier League")

# FootballReview.create(rating: 7, content: review_four, user_id: User.first.id, football_score_id: FootballScore.last.id)
