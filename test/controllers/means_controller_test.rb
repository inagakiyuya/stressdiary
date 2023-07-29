require "test_helper"

class MeansControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get means_index_url
    assert_response :success
  end

  test "should get new" do
    get means_new_url
    assert_response :success
  end

  test "should get show" do
    get means_show_url
    assert_response :success
  end

  test "should get edit" do
    get means_edit_url
    assert_response :success
  end
end
