require 'test_helper'

class FootballScoresFlowTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @first_score = football_scores(:FirstScore)
    @first_user = users(:FirstUser)
  end

  test "generic football scores flow" do
    sign_in @first_user
    get football_scores_url
    assert_response :success

    get football_scores_url(@first_score)
    assert_response :success
  end


end
