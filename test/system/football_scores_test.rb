require "application_system_test_case"

class FootballScoresTest < ApplicationSystemTestCase
  def setup
    @first_user = users(:FirstUser)
    @first_team = football_teams(:WestHam)
    @second_team = football_teams(:Chelsea)
    @first_score = football_scores(:FirstScore)
    @second_score = football_scores(:SecondScore)
    @first_review = football_reviews(:FirstReview)
    @second_review = football_reviews(:SecondReview)
  end

  test "check for key texts in football scores index and click review" do
    login_as @first_user
    visit football_scores_url

    assert_text @first_score.home_team_name
    assert_text @first_score.home_team_fulltime_score
    assert_text @first_score.away_team_name
    assert_text @first_score.home_team_fulltime_score
  end

  test "user should click on football_score" do
    visit football_scores_url
    click_on @second_score.home_team_name

    review_categories = ["All", @second_score.home_team_name, @second_score.away_team_name, "Neutral"]
    assert_equal football_score_path(@second_score), page.current_path
    assert_text "Sign in with twitter to review a game"
    assert_text "#{review_categories.sample} Fan Reviews"
    click_on "#{review_categories.sample} Fan Reviews"
    click_on "Sign in with twitter to review a game"

  end

  test "test search function" do
    visit football_scores_url
    assert_text @first_score.home_team_name

    find(:css, "input[id$='q_home_team_name_or_away_team_name_or_competition_name_cont']").set("#{@second_score.home_team_name}")
    fill_in 'q_home_team_name_or_away_team_name_or_competition_name_cont', with: "#{@second_score.home_team_name.slice(0..2)}"
    assert_text @second_score.home_team_name
    assert_no_text @first_score.home_team_name
    page.save_screenshot()
  end

  test "test search filter function" do
    login_as @first_user
    visit football_scores_url
    assert_text @second_score.home_team_name

    check @first_score.competition_name
    assert_text @first_score.away_team_name
    assert_no_text @second_score.home_team_name

    uncheck @first_score.competition_name
    assert_text @second_score.home_team_name
  end

  test "user should see reviews in right categories" do
    login_as @first_user
    visit football_score_url(@first_score)

    assert_equal football_score_path(@first_score), page.current_path
    assert_text "Review this game"
    assert_text @first_review.content

    click_on "#{@first_score.away_team_name} Fan Reviews"
    sleep 2
    assert_no_text @first_review.content

    click_on "Neutral Fan Reviews"
    sleep 2
    assert_text @first_review.rating
    assert_text "/10"

    click_on "Review this game"
    assert_equal new_football_score_football_review_path(@first_score), page.current_path
  end

  test "user should continue to see reviews in right categories " do
    login_as @first_user
    @first_user.football_team = @first_team
    visit football_score_url(@first_score)
    assert_equal football_score_path(@first_score), page.current_path
    assert_text @first_review.content

    click_on "#{@first_score.home_team_name} Fan Reviews"
    sleep 2
    assert_no_text @first_review.content

    click_on "#{@first_score.away_team_name} Fan Reviews"
    sleep 2
    assert_text @first_review.content

    click_on "Neutral Fan Reviews"
    sleep 2
    assert_no_text @first_review.rating
  end

  test "still testing reviews in right categories" do
    @first_user.football_team = @second_team
    visit football_score_url(@second_score)
    assert_equal football_score_path(@second_score), page.current_path

    assert_text @second_review.user.username

    click_on "#{@second_score.away_team_name} Fan Reviews"
    sleep 2
    assert_no_text @second_review.content

    click_on "Neutral Fan Reviews"
    sleep 2
    assert_no_text @second_review.content

    click_on "#{@second_score.home_team_name} Fan Reviews"
    sleep 2
    assert_text @second_review.content
  end

end
