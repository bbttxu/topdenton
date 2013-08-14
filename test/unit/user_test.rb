require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @user = FactoryGirl.build :user
    @new_user = FactoryGirl.create :user
  end

  test "new user should not have a role" do
    assert @user.roles.blank?, "user should not have role"
  end

  test "saved new user should have a role" do
    assert ! @user.roles.blank?, "saved user does not have any role"
  end

  test "saved new user should be assigned the rater role" do
    @user.save
    assert @user.has_role? :rater, "saved user does not have rater role"
  end
end
