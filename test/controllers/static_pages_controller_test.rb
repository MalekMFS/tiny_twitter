require 'test_helper'

class StaticPagesControllerTest < ActionController::TestCase
  test "should get home" do
    get :home
    assert_response :success
    assert_select "title", "برنامه موقت"
  end

  test "should get help" do
    get :help
    assert_response :success
    assert_select "title", "راهنما | برنامه موقت"
  end

  test "should get about" do
    get :about
    assert_response :success
    assert_select "title", "درباره | برنامه موقت"
  end

end
