require 'test_helper'

class FootballTeamsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @first_user = users(:FirstUser)
    @first_team = football_teams(:WestHam)
  end

  test "should get index" do
    sign_in @first_user
    get football_teams_url
    assert_response :success
  end

  test "should not get index if not signed in" do
    get football_teams_url
    assert_response :redirect
  end

  test "should be able attach a football club to the logged in user" do
    sign_in @first_user
    get football_teams_url
    post football_teams_url, params: { user: @first_user, team: @first_team.id }
    assert_equal @first_user.football_team.name, @first_team.name
  end

  test "should check for flash notice and redirect to football scores index" do
    sign_in @first_user
    get football_teams_url
    post football_teams_url, params: { user: @first_user, team: @first_team.id }
    assert_equal "You have chosen #{@first_user.football_team.short_name} as your club", flash[:notice]
    assert_redirected_to football_scores_path
  end

 #View tests
  test "for radio form inputs on index" do
    sign_in @first_user
    get football_teams_url
    assert_select "input[type=radio]"
  end

  test "for submit form inputs on index" do
    sign_in @first_user
    get football_teams_url
    assert_select "input[type=submit]"
  end

  test "for a tags om index" do
    sign_in @first_user
    get football_teams_url
    assert_select 'a'
  end

end
