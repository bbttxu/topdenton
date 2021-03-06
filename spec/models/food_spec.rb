# food_spec.rb

require 'spec_helper'

describe "food" do
  before(:each) do
    @food = FactoryGirl.build :food
  end

  describe "model" do
    it "is valid" do
      @food.should be_valid
    end

    it "needs a name" do
      food = FactoryGirl.build :food, name: ""
      food.should_not be_valid
    end

    it "needs a address" do
      food = FactoryGirl.build :food, address: ""
      food.should_not be_valid
    end

    it "needs a city" do
      food = FactoryGirl.build :food, city: ""
      food.should_not be_valid
    end

    it "needs a state" do
      food = FactoryGirl.build :food, state: ""
      food.should_not be_valid
    end

    it "does not need a zipcode, can geocode without" do
      food = FactoryGirl.build :food, zipcode: ""
      food.should be_valid
    end

    it "needs a phone" do
      food = FactoryGirl.build :food, phone: ""
      food.should_not be_valid
    end
  end

  describe 'lower case tags' do
    it "has only lower case tags" do
      @food.tags = "Should,BE,LowerCase"
      @food.save
      @food.tags.should eq("should,be,lowercase")
    end
  end
end