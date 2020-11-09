class PagesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @first_user = users(:FirstUser)
  end

  test "should get about" do
    get about_url
    assert_response :success
  end

  test "should get users sign in" do
    get new_user_session_url
    assert_response :success
  end

end
