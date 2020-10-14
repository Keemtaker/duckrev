require 'test_helper'

class FootballReviewsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @first_user = users(:FirstUser)
    @first_score = football_scores(:FirstScore)
  end

  test "should get new page" do
    sign_in @first_user
    get new_football_score_football_review_url(@first_score)
    assert_response :success
  end

  test "should should not get new page if user is not authenticated" do
    get new_football_score_football_review_url(@first_score)
    assert_response :redirect
  end

  #View test
  test "for submit form inputs on index" do
    sign_in @first_user
    get new_football_score_football_review_url(@first_score)
    assert_select "input[type=submit]"
  end
end
