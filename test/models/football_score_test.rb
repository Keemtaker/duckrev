require 'test_helper'

class FootballScoreTest < ActiveSupport::TestCase

  def setup
    @first_score = football_scores(:FirstScore)
    @second_score = football_scores(:SecondScore)
  end

  test "football scores rake task" do
    assert Rake::Task['football_scores_data'].invoke
  end

  test "football score is not valid with missing attributes" do
    @first_score.home_team_name = nil
    assert @first_score.invalid?
  end

  test "uniqueness of match id" do
    @second_score.match_id = 1
    assert @second_score.invalid?
  end

  test "competition id outside of accepted list its not valid" do
    @second_score.match_id = 4
    @second_score.competition_id = 7
    assert @second_score.invalid?
  end

  test "rake task can archive football scores older than specified time" do
    FootballScore.second.update(created_at: 25.hours.ago)
    assert Rake::Task['archive_football_scores'].invoke
    assert FootballScore.second.archived_state?
    assert_not FootballScore.second.average_reviews?
    assert_not FootballScore.first.archived_state?
  end

  test "rake task can archive football scores and generate average reviews" do
    FootballScore.first.update(created_at: 25.hours.ago)
    FootballScore.first.update(score_tweet_id: "1321161644010033154")
    assert Rake::Task['archive_football_scores'].invoke
    assert FootballScore.first.archived_state?
    assert FootballScore.first.average_reviews?
  end

end
