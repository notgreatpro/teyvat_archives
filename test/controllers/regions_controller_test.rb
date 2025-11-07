require "test_helper"

class RegionsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get regions_index_url
    assert_response :success
  end

  test "should get show" do
    get regions_show_url
    assert_response :success
  end
end
