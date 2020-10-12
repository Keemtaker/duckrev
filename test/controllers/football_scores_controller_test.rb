require 'test_helper'

class FootballScoresControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @first_score = football_scores(:FirstScore)
    @first_user = users(:FirstUser)
  end

  test "should get index" do
    sign_in @first_user
    get football_scores_url
    assert_response :success
  end

  test "should still get index if user is not signed in" do
    get football_scores_url
    assert_response :success
  end

  test "should get show page" do
    get football_score_url(@first_score)
    assert_response :success
  end

  #View tests
  test "for elements on index" do
    sign_in @first_user
    get football_scores_url
    assert_select "div", @first_score.competition_name
    assert_select 'a'
  end

  test "for elements on show" do
    get football_scores_url
    assert_select "div", @first_score.competition_name
    assert_select 'a'
  end

end
