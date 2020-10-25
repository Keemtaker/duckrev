require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @first_user = users(:FirstUser)
  end

  test "User is not valid with missing attribute" do
    @first_user.uid = nil
    assert @first_user.invalid?
  end

  test "User can have a football team" do
    @first_user.football_team = FootballTeam.new(name: "Madrid", short_name: "MAD", team_country: "Spain", team_api_id: 12)
    assert @first_user.valid?
  end

  test "User can have only one football team" do
    assert_nil @first_user.football_team
  end

  test "User access token can be encrypted and decrypted" do
    raw_token = @first_user.access_token
    @first_user.access_token = @first_user.encrypt_field(@first_user.access_token)
    assert_not_equal raw_token, @first_user.access_token

    @first_user.access_token = EncryptionService.decrypt(@first_user.access_token)
    assert_equal raw_token, @first_user.access_token

  end

end
