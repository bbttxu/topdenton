require 'test_helper'

class AbilityTest < ActiveSupport::TestCase

  test "anonymouse user cannot rate stuff" do
    user = FactoryGirl.build :user
    ability = Ability.new(user)
    assert ability.cannot? :rate, Rating, "anonymous can rate food"
  end

  test "twitter user can rate stuff" do
    user = FactoryGirl.create :user
    ability = Ability.new(user)
    assert ability.can? :rate, Food, "twitter cannot rate food"
  end

end