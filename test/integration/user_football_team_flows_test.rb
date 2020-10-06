require 'test_helper'

class UserFootballTeamFlowsTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @first_user = users(:FirstUser)
    @first_team = football_teams(:WestHam)
    @first_score = football_scores(:FirstScore)
  end

  test "user can choose a football team flow" do
    sign_in @first_user
    get football_teams_url
    assert_response :success

    post football_teams_url, params: { user: @first_user, team: @first_team.id }
    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_select "h3", "Fulltime Scores"
    assert_select "div", @first_score.competition_name
    assert_select "li"
  end

end
