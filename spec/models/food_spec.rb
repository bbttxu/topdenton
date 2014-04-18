# food_spec.rb

require 'spec_helper'

describe "food" do

  describe "model" do
    before(:each) do
      @food = FactoryGirl.build :food
    end

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

    it "needs a zipcode" do
      food = FactoryGirl.build :food, zipcode: ""
      food.should_not be_valid
    end

    it "needs a phone" do
      food = FactoryGirl.build :food, phone: ""
      food.should_not be_valid
    end

  end
end