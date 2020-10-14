require 'test_helper'

class FootballReviewsFlowTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @first_score = football_scores(:FirstScore)
    @first_user = users(:FirstUser)
  end

  test "generic football reviews flow" do
    sign_in @first_user

    get football_scores_url(@first_score)
    assert_response :success

    get new_football_score_football_review_url(@first_score)
    assert_response :success
  end

end
