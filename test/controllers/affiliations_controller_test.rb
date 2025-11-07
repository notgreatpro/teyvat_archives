require "test_helper"

class AffiliationsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get affiliations_index_url
    assert_response :success
  end

  test "should get show" do
    get affiliations_show_url
    assert_response :success
  end
end
