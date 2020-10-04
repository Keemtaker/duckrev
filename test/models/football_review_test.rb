require 'test_helper'

class FootballReviewTest < ActiveSupport::TestCase

  def setup
    @review = football_reviews(:FirstReview)
  end

  test "basic test" do
    assert_not_nil @review
  end
end
