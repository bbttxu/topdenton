# user_spec.rb

require 'spec_helper'

describe User do

  before(:each) do
    @user = FactoryGirl.create :user
  end

  describe "model" do
    it "is valid" do
      @user.should be_valid()
    end
  end

  describe "roles" do
    it "assigns a default rater role" do
      expect(@user.roles.count).to eq(1)
    end
  end
end