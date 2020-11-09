require "mobile_system_test_case"

class MobileViewsTest < MobileSystemTestCase

  def setup
    @first_user = users(:FirstUser)
    @first_team = football_teams(:WestHam)
    @second_team = football_teams(:Chelsea)
    @first_score = football_scores(:FirstScore)
    @second_score = football_scores(:SecondScore)
    @first_review = football_reviews(:FirstReview)
    @second_review = football_reviews(:SecondReview)
  end

  test "test search function mobile" do
    visit football_scores_url
    assert_text @first_score.home_team_name

    find(:css, "input[id$='q_home_team_name_or_away_team_name_or_competition_name_cont']").set("#{@second_score.home_team_name}")
    fill_in 'q_home_team_name_or_away_team_name_or_competition_name_cont', with: "#{@second_score.home_team_name.slice(0..2)}"
    assert_text @second_score.home_team_name
    assert_no_text @first_score.home_team_name
  end

  test "test search filter function mobile" do
    login_as @first_user
    visit football_scores_url
    assert_text @second_score.home_team_name

    click_on "Competitions"
    check @first_score.competition_name
    assert_text @first_score.away_team_name
    assert_no_text @second_score.home_team_name

    uncheck @first_score.competition_name
    assert_text @second_score.home_team_name
  end

  test "Check about page, navbar and footer for mobile" do
    visit root_url
    click_on(class: 'navbar-toggler')
    click_on "About"
    assert_text "Sign in with Twitter"

    login_as @first_user
    click_on(class: 'navbar-toggler')
    click_on "About"
    assert_no_text "Sign in with Twitter"
    click_on(class: 'navbar-toggler')
    assert_text "Log Out"

    click_on(class: 'navbar-toggler')
    click_on "Football Scores", match: :first
    assert_equal "/football_scores", page.current_path

    click_on(id: 'footer-scores')
    assert_equal "/football_scores", page.current_path

    click_on(class: 'navbar-toggler')
    click_on(class: 'navbar-toggler')

    click_on "@DuckrevFootball", match: :first
  end

end
