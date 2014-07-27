require 'spec_helper'

describe UsersController do

  describe "admin user" do
    before do
      @user = FactoryGirl.create :user
      @user.add_role(:admin)
      session[:user_id] = @user.id
    end

    it "should see index of users" do
      get :index
      response.should be_success
    end
  end

  describe "regular user" do
    before do
      @user = FactoryGirl.create :user
      session[:user_id] = @user.id
    end

    it "should NOT see index of users" do
      get :index
      response.should_not be_success
    end
  end

end
