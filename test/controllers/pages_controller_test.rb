class PagesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @first_user = users(:FirstUser)
  end

  test "should get about" do
    get about_url
    assert_response :success
  end

end
