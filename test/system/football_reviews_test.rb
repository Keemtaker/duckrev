require "application_system_test_case"

class FootballReviewsTest < ApplicationSystemTestCase
  def setup
    @second_user = users(:SecondUser)
    @first_score = football_scores(:FirstScore)
    @second_score = football_scores(:SecondScore)
    @third_score = football_scores(:ThirdScore)
    @first_team = football_teams(:WestHam)
    @second_team = football_teams(:Chelsea)
    # @third_team = football_teams(:Madrid)
  end

  test "check for key texts in football review new page" do
    login_as @second_user
    visit new_football_score_football_review_url(@second_score)

    assert_text @second_score.home_team_name
    assert_text "Your review will be sent out as a tweet"
    assert_selector "input[type=submit]"
  end

  test "review the game as a team fans" do
    login_as @second_user
    @second_user.football_team = @second_team
    visit new_football_score_football_review_url(@second_score)

    assert_text "You chose #{@second_user.football_team.short_name} as your club, so you will review this game as a #{@second_user.football_team.short_name} fan"
  end

  test "review the game as a neutral fan but still attached to a club " do
    login_as @second_user
    @second_user.football_team = @first_team
    visit new_football_score_football_review_url(@second_score)

    assert_text "You chose #{@second_user.football_team.short_name} as your club, so you will review this game as a Neutral fan"
  end

  test "lets make a review" do
    login_as @second_user
    visit new_football_score_football_review_url(@second_score)
    assert_text "You have not chosen any club yet, so you will review this game as a Neutral fan"

    assert_difference 'FootballReview.count' do
      select '9', from: 'Rating'
      fill_in "Content", with: "The lads did great today"
      click_on "Tweet Review"

      sleep 2
      assert_equal "/football_scores", page.current_path
      assert_text "Thanks for your #{@second_user.football_reviews.count.ordinalize} game review"
    end
  end

  test "an attempted review is invalid without the right parameters" do
    login_as @second_user
    visit new_football_score_football_review_url(@second_score)

    assert_no_difference 'FootballReview.count' do
      select '10', from: 'Rating'
      fill_in "Content", with: "The lads did great today" * 60
      click_on "Tweet Review"
    end
  end

  test "tweet character count" do
    login_as @second_user
    visit new_football_score_football_review_url(@second_score)

    select '8', from: 'Rating'
    fill_in "Content", with: "lads"
    assert_text "Charecter count: 266"
  end

end
