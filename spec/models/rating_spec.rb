# rating_spec.rb


require 'spec_helper'

describe "rating" do
  describe "model" do
    before(:each) do
      @rating = FactoryGirl.build :rating
    end

    it "uses only lowercase tags" do
      @rating.tags = "Hello,World"
      @rating.save
      expect(@rating.tags).to eq("hello,world")
    end
  end
end