require 'test_helper'

class RelationshipTest < ActiveSupport::TestCase

  def setup
    @Relationship = Relationship.new(follower_id: 1, followed_id: 2)
  end

  test "should be valid" do
    assert @Relationship.valid?
  end

  test "should require a follower_id" do
    @Relationship.follower_id = nil
    assert_not @Relationship.valid?
  end
  test "should require a followed_id" do
    @Relationship.followed_id = nil
    assert_not @Relationship.valid?
  end


end
