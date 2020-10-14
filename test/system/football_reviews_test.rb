require "application_system_test_case"

class FootballReviewsTest < ApplicationSystemTestCase
  def setup
    @second_user = users(:SecondUser)
    @second_score = football_scores(:SecondScore)
  end

  test "check for key texts in football review new page" do
    login_as @second_user
    visit new_football_score_football_review_url(@second_score)

    assert_text @second_score.home_team_name
    assert_text "Your review will be sent out as a tweet"
    assert_selector "input[type=submit]"
  end

  test "lets make a review" do
    login_as @second_user
    visit new_football_score_football_review_url(@second_score)

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

end
