
# food_spec.rb

require 'spec_helper'

describe "abilities" do
  before(:each) do
    @user = FactoryGirl.build :user
  end

  describe "random user" do
    before(:each) do
      @ability = Ability.new(@user)
    end

    it "can see landing page food" do
      @ability.can?( :landing, Food ).should be_true
    end

    it "cannot rate food" do
      @ability.cannot?( :rate, Rating ).should eq(true)
    end

    it "cannot edit food" do
      @ability.can?( :edit, Food ).should be_false
    end
  end

  describe "rating user" do
    before(:each) do
      @user.add_role(:rater)
      @ability = Ability.new(@user)
    end

    it "can rate food" do
      @ability.can?( :rate, Food ).should be_true
    end

    it "cannot edit food" do
      @ability.can?( :edit, Food ).should be_false
    end
  end

  describe "admin user" do
    before(:each) do
      @user.add_role(:admin)
      @ability = Ability.new(@user)
    end

    it "can rate food" do
      @ability.can?( :rate, Food ).should be_true
    end

    it "can create food" do
      @ability.can?( :create, Food ).should be_true
    end

    it "can edit food" do
      @ability.can?( :edit, Food ).should be_true
    end

    it "can edit user" do
      @ability.can?( :edit, User ).should be_true
    end
  end
end

