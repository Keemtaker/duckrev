require "application_system_test_case"

class FootballTeamsTest < ApplicationSystemTestCase

  def setup
    @first_user = users(:FirstUser)
    @first_team = football_teams(:WestHam)
    @first_score = football_scores(:FirstScore)
  end

  test "check for key texts in football teams index" do
    login_as @first_user
    visit football_teams_url

    assert_text @first_team.team_country
    assert_text @first_team.short_name
    assert_selector "input[type=submit]"
    assert_text "Skip and choose team later"
  end

  test "user should choose a football team" do
    login_as @first_user
    visit football_teams_url
    choose @first_team.short_name
    click_on "Submit"

    assert_equal "/football_scores", page.current_path
    assert_text "Fulltime Scores"
    assert_no_text "Choose Football Club"
    assert_equal @first_user.football_team.name, @first_team.name
  end

  test "user can skip and choose football team later" do
    login_as @first_user
    visit football_teams_url
    choose @first_team.short_name
    click_on "Skip and choose team later"

    assert_equal "/football_scores", page.current_path
    assert_text "Fulltime Scores"
    assert_text "Choose Football Club"
    assert_nil @first_user.football_team
  end

  test "user can click on another tab and choose a club" do
    @second_team = FootballTeam.create(name: "Madrid", short_name: "MAD", team_country: "Spain", team_api_id: 12)
    login_as @first_user
    visit football_teams_url
    click_on @second_team.team_country
    choose @second_team.short_name
    click_on "Submit"

    assert_equal "/football_scores", page.current_path
    assert_text "Fulltime Scores"
    assert_equal @first_user.football_team.name, @second_team.name
  end

end
