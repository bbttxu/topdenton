require 'test_helper'

class FoodTest < ActiveSupport::TestCase
  def setup
    @food = FactoryGirl.build :food
    Rating.tagged_with("asdf").delete_all
  end

  test "should have valid factory model" do
    assert @food.valid?
  end

  test "should have a lowercase tag" do
    @food.tags = "BBQ"
    @food.save

    assert @food.tags == "bbq", "tag not lowercase"
  end

  test "should get a rating with a tag" do
    tag = "asdf"
    first_count = Rating.tagged_with(tag).count

    @food.tags = tag
    @food.save
    second_count = Rating.tagged_with(tag).count

    assert (first_count < second_count), "first is not less than the second"
  end

  test "should delete any ratings on destroy" do
    tag = "asdf"
    @food.tags = tag
    @food.save

    first_count = Rating.tagged_with(tag).count

    @food.destroy
    second_count = Rating.tagged_with(tag).count

    assert (first_count > second_count), "first is not greater than the second"
  end
end
