require 'spec_helper'

describe FoodsController do
  # config.include Devise::TestHelpers, type: :controller
  before do
    @food = FactoryGirl.create :food
    @rating = FactoryGirl.create :rating
  end



  describe "admin" do
    before do
      @user = FactoryGirl.create :user
      @user.add_role(:admin)
      session[:user_id] = @user.id

      @food = {
        name: "Banter",
        address: "815 Oak St",
        city: "Denton",
        state: "TX",
        zipcode: "76201",
        phone: "940-867-1209"
      }
    end

    it "should get index" do
      get :index
      response.should be_success
      assert_not_nil assigns(:foods)
    end

    it "should be able to create food"
    it "should be able to edit food"

  end


  describe "rater" do
    before do
      @user = FactoryGirl.create :user
      @user.add_role(:rater)
      session[:user_id] = @user.id
    end

    it "should get rating page" do
      get :rate, id: @food
      response.should be_success
    end
  end

  describe "anonymous" do
    before do
      @user = FactoryGirl.create :user
      @user.remove_role :rater
      session[:user_id] = @user.id
    end

    it "should get index" do
      get :index
      response.should be_success
    end

    it "should get landing page" do
      get :landing
      response.should be_success
    end

    it "should get detail page" do
      get :show, id: @food
      response.should be_success
    end
  end
end
