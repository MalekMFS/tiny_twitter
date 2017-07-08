require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  test "should get login (new)" do
    get login_url
    assert_response :success
  end

end
