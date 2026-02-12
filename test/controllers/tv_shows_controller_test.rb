require "test_helper"

class TvShowsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get tv_shows_index_url
    assert_response :success
  end

  test "should get show" do
    get tv_shows_show_url
    assert_response :success
  end
end
