require 'test_helper'

class ArticlesControllerTest < ActionController::TestCase
  test "Index action returns a list of articles" do
    get :index
    assert_response :success
  end
end
