require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
  	@user = User.new(name: "Example User", email: "user@example.com", password: "foobar", password_confirmation: "foobar")
  end

  test "Should be valid" do
  	assert @user.valid?
  end

  test "name should be presense" do
  	@user.name = "        "
  	assert_not @user.valid?
  end

  test "email should be presense" do
  	@user.email = "        "
  	assert_not @user.valid?
  end

  test "name should not be too long" do
  	@user.name = "a"*51
  	assert_not @user.valid?
  end

  test "email should not be too long" do
  	@user.email = "a"*256
  	assert_not @user.valid?
  end

  test "email validation should accept valid addresses" do
  	valid_addresses = %w[ user@example.com USER@foo.COM A_US-ER@foo.bar.org first.last@foo.jp alice+bob@baz.cn ]

  	valid_addresses.each do |valid_address|
  		@user.email = valid_address
  		assert @user.valid?, "#{valid_address.inspect} should be valid"
  	end
  end
  test "email validation should reject invalid addresses" do
  	invalid_addresses = %w[ user@example,com user_at_foo.org user.name@example. foo@bar_baz.com foo@bar+baz.com foo@bar..com ]

  	invalid_addresses.each do |invalid_address|
  		@user.email = invalid_address
  		assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
  	end
  end

  test "email address should be unique" do
  	duplicate_user = @user.dup
  	duplicate_user.email = @user.email.upcase
  	@user.save
  	assert_not duplicate_user.valid?
  end

  test "email addresses should be saved as lower-case" do
  	mixed_case_email = "Foo@ExAMPle.CoM"
  	@user.email = mixed_case_email
  	@user.save
  	assert_equal mixed_case_email.downcase, @user.reload.email
	end

  test "password should have a minimum length" do
  	@user.password = @user.password_confirmation = "a"*5
  	assert_not @user.valid?
  end

  test "authenticated? should return false for a user with nil digest" do
    #@user's digest field is nil & Dosn't matter how
    assert_not @user.authenticated?(:remember,'')
  end

  test "associated microposts should be destroyed" do
    @user.save
    @user.microposts.create!(content:"سلام چطوری")
    assert_difference 'Micropost.count', -1 do
      @user.destroy
    end
  end

  test "should follow and unfollow a user" do
    one = users(:one)
    two = users(:two)
    assert_not one.following?(two)
    one.follow(two)
    assert one.following?(two)
    assert two.followers.include?(one)
    one.unfollow(two)
    assert_not one.following?(two)
  end

  test "feed should have the right posts" do
    one     = users(:one)
    two     = users(:two)
    michael = users(:michael)
    # Posts from followed user
    michael.microposts.each do |post_following|
      assert one.feed.include?(post_following)
    end
    # Posts from self
    one.microposts.each do |post_self|
      assert one.feed.include?(post_self)
    end
    # Posts from unfollowed user
    two.microposts.each do |post_unfollowed|
      assert_not one.feed.include?(post_unfollowed)
    end
  end

end
