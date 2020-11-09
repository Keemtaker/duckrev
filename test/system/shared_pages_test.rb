require "application_system_test_case"

class SharedPagesTest < ApplicationSystemTestCase
  def setup
    @first_user = users(:FirstUser)
  end

  test "Check that sign in page works okay" do
    visit new_user_session_url
    click_on(class: 'btn btn-primary btn-lg')
  end

  test "Check about page, navbar and footer" do
    visit root_url
    click_on "About"
    assert_text "Sign in with Twitter"

    login_as @first_user
    click_on "About"
    assert_no_text "Sign in with Twitter"
    assert_text "Log Out"

    click_on "Football Scores", match: :first
    assert_equal "/football_scores", page.current_path

    click_on "About"
    assert_equal "/about", page.current_path
    click_on(id: 'footer-scores')
    assert_equal "/football_scores", page.current_path

    click_on "Log Out"
    assert_equal "/", page.current_path
    assert_text "Sign in with Twitter"
  end

end
