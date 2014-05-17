class UsersController < ApplicationController

  load_and_authorize_resource 

  # GET /users
  # GET /users.json
  def index
    @users = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users, callback: params[:callback] }
    end
  end


  def toggle
    @user = User.find(params[:id])

    if @user.has_role? :admin
    	@user.remove_role :admin
  	else
    	@user.add_role :admin
  	end

    respond_to do |format|
      if @user.update_attributes(params[:food])
        format.html { redirect_to users_url, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @food.errors, status: :unprocessable_entity }
      end
    end
  end

end
