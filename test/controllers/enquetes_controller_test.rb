require "test_helper"

class EnquetesControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get enquetes_show_url
    assert_response :success
  end

  test "should get new" do
    get enquetes_new_url
    assert_response :success
  end

  test "should get edit" do
    get enquetes_edit_url
    assert_response :success
  end
end
