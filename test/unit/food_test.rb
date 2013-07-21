require 'test_helper'

class FoodTest < ActiveSupport::TestCase
  def setup
    @food = FactoryGirl.build :food
  end

  test "should have a name" do
    assert @food.name
  end
end
