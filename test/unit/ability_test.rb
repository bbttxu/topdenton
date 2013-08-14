require 'test_helper'

class AbilityTest < ActiveSupport::TestCase

  test "anonymouse user can rate stuff" do
    @user = FactoryGirl.build :user
    @ability = Ability.new(@user)
    assert ability.cannot? :rate, Rating
  end

  test "twitter user can rate stuff" do
    @user = FactoryGirl.create :user
    @ability = Ability.new(@user)
    assert ability.can? :rate, Rating
  end
end