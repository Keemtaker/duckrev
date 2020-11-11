require 'test_helper'

class FootballReviewTest < ActiveSupport::TestCase

  def setup
    @first_review = football_reviews(:FirstReview)
    @first_score = football_scores(:FirstScore)
    @second_score = football_scores(:SecondScore)
    @third_user = users(:ThirdUser)

  end

  test "football review is not valid with rating outside 1..10" do
    @first_review.rating = 12
    assert @first_review.invalid?
  end

  test "football review is not valid with content over the maximum" do
    @first_review.content = "#{@first_review.content}" * 100
    assert @first_review.invalid?
  end

  test "football review is not valid with archived score" do
    new_review = FootballReview.new(content: "amazing game by the lads", rating: 2, football_score_id: @second_score.id, user_id: @third_user.id )
    new_review.football_score.archived_state = true
    assert new_review.invalid?
  end

  test "user can review a score just once" do
    new_review = FootballReview.new(rating: 8, content: "nice performance", football_score_id: @first_review.football_score.id, user_id: @first_review.user_id)
    assert new_review.invalid?
  end
end
