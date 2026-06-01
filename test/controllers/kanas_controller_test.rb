require "test_helper"

class KanasControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get kanas_index_url
    assert_response :success
  end
end
