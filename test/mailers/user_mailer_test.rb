require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
  test "account_activation" do
    user = users(:one)
    user.activation_token = User.new_token
    mail = UserMailer.account_activation(user)
    assert_equal "فعال سازی حساب کاربری",  mail.subject
    assert_equal [user.email],            mail.to
    assert_equal ["noreply@meam.ir"], mail.from
    #NOTE force to match as UTF-8
    assert_match user.name,               mail.text_part.body.to_s.encode("UTF-8")
    assert_match user.activation_token,   mail.text_part.body.to_s.encode("UTF-8")
    assert_match CGI.escape(user.email),  mail.text_part.body.to_s.encode("UTF-8")
  end

  test "password reset" do
    user = users(:one)
    user.reset_token = User.new_token
    mail = UserMailer.password_reset(user)
    assert_equal "بازیابی رمزعبور",  mail.subject
    assert_equal [user.email],            mail.to
    assert_equal ["noreply@meam.ir"], mail.from
    assert_match user.name,               mail.text_part.body.to_s.encode("UTF-8")
    assert_match user.reset_token,   mail.text_part.body.to_s.encode("UTF-8")
    assert_match CGI.escape(user.email),  mail.text_part.body.to_s.encode("UTF-8")
  end

end
