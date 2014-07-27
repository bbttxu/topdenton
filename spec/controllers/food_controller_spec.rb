require 'spec_helper'

describe FoodsController, :type => :controller do
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

      @newfood = FactoryGirl.build :food, name: 'new food'
    end

    it "should get index" do
      get :index
      response.should be_success
      assert_not_nil assigns(:foods)
    end

    it "should be able to create new food" do
      get :new
      response.should be_success
    end

    it "should create new food" do
      assert_difference('Food.count') do
        post :create, food: @newfood.attributes
      end

      assert_redirected_to food_path(assigns(:food))
    end

    it "should be able to update food" do
      @newfood.save
      put :update, id: @newfood.to_param, food: @newfood.attributes
      assert_redirected_to food_path(assigns(:food))
    end

    it "should be able to destroy food" do
      @newfood.save
      assert_difference('Food.count', -1) do
        delete :destroy, id: @newfood.to_param
      end

      assert_redirected_to foods_path
    end
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
