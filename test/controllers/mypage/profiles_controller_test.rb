require "test_helper"

class Mypage::ProfilesControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get mypage_profiles_show_url
    assert_response :success
  end

  test "should get update" do
    get mypage_profiles_update_url
    assert_response :success
  end
end
