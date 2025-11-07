require "test_helper"

class WeaponTypesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get weapon_types_index_url
    assert_response :success
  end

  test "should get show" do
    get weapon_types_show_url
    assert_response :success
  end
end
