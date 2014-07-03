require 'spec_helper'

describe FoodsController do
  # config.include Devise::TestHelpers, type: :controller

  before do
		# @food = FactoryGirl.build :food
	end

  describe "POST to create" do
    # include Devise::TestHelpers
    # puts "%"*80

    before do
      @user = FactoryGirl.build :user
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

    it "for admin, should change the number of foods" do
      # lambda do
      #   # puts @food
      #   # puts Food.new(@food).errors.collect{|x| x.keys}
      #   post :create, @food
      # end.should change(Food, :count).by(1)
    end

  	it "should get new"
  	it "should create food"
  end

  describe "JSON interaction" do
    it "should return JSON"
    it "should respond properly to a JSONP callback"
  end
end

# test "should get index" do
#   get :index
#   assert_response :success
#   assert_not_nil assigns(:foods)
# end

# test "should get new" do
#   get :new
#   assert_response :success
# end

# test "should create food" do
#   assert_difference('Food.count') do
#     post :create, food: { address: @food.address, latitude: @food.latitude, longitude: @food.longitude, name: @food.name, phone: @food.phone, state: @food.state, zipcode: @food.zipcode }
#   end

#   assert_redirected_to food_path(assigns(:food))
# end

# test "should show food" do
#   get :show, id: @food
#   assert_response :success
# end

# test "should get edit" do
#   get :edit, id: @food
#   assert_response :success
# end

# test "should update food" do
#   put :update, id: @food, food: { address: @food.address, latitude: @food.latitude, longitude: @food.longitude, name: @food.name, phone: @food.phone, state: @food.state, zipcode: @food.zipcode }
#   assert_redirected_to food_path(assigns(:food))
# end

# test "should destroy food" do
#   assert_difference('Food.count', -1) do
#     delete :destroy, id: @food
#   end

#   assert_redirected_to foods_path
# end
