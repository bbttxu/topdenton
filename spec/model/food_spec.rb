# food_spec.rb

require 'spec_helper'


describe "food" do

  describe "model" do
    before(:each) do
      @food = Food.new
      @food = FactoryGirl.build :food
    end

    it "does some things" do
      pending
    end

  end

end