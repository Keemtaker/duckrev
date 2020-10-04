require 'test_helper'

class FootballScoreTest < ActiveSupport::TestCase

  def setup
     @first_score = football_scores(:FirstScore)
     @second_score = football_scores(:SecondScore)
  end

  test "football scores rake task" do
    assert Rake::Task['footie_scores_data'].invoke
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

end
