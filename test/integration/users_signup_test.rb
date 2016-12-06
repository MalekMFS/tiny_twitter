require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest

  test "invalid signup information" do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, user: {name: "",
                              email: "user@invalid",
                              password: "foo",
                              password_confirmation: "bar"}
    end
    assert_template 'users/new'
    assert_select 'div#error_explanation'
    assert_select 'div.field_with_errors'
  end

  test "valid signup information" do
    get signup_path
    assert_difference 'User.count', 1 do #should have 1 difference
    post users_path, user: {name:  "example User",
                                         email: "user@valid.us",
                                         password:              "password",
                                         password_confirmation: "password"}
    follow_redirect! #follow redirect (to assert_template pass)
    end
    assert_template 'users/show'
    assert is_logged_in?                   #check test_helper
    assert_not_nil flash                #assert_not flash.nil?
  end
end
