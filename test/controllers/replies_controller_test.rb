require "test_helper"

class RepliesControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get replies_show_url
    assert_response :success
  end

  test "should get edit" do
    get replies_edit_url
    assert_response :success
  end
end
