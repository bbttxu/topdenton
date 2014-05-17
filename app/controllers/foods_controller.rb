class FoodsController < ApplicationController

  skip_before_filter :authenticate_user! 

  load_and_authorize_resource 


  # GET /foods
  # GET /foods.json
  def index
    @foods = Food.all

    @tags = Food.all.tags


    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @foods, callback: params[:callback] }
    end
  end

  # GET /foods/1/rate
  # GET /foods/1.json
  # NB id is tag name for a Rating, not an id
  def rate
    @tag = params[:id]


    @ratings = Rating.tagged_with(@tag)
    @rated = @ratings.rated_by(current_user)
    # @unrated = Rating.unrated_by(current_user).tagged_with(params[:tag])
    # @unrated = @ratings - @rated

    @tagged_foods = Food.tagged_with @tag


    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @rated }
    end
  end


  # GET /foods/1
  # GET /foods/1.json
  def show
    @food = Food.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @food, callback: params[:callback] }
    end
  end

  # GET /foods/new
  # GET /foods/new.json
  # def new
  #   @food = Food.new

  #   respond_to do |format|
  #     format.html # new.html.erb
  #     format.json { render json: @food }
  #   end
  # end

  # GET /foods/1/edit
  # def edit
  #   @food = Food.find(params[:id])
  # endds

  # POST /foods
  # POST /foods.json
  def create
    # debugger
    @food = Food.new(params[:food])

    respond_to do |format|
      if @food.save
        puts "DID SAVE "*5
        format.html { redirect_to @food, notice: 'Food was successfully created.' }
        format.json { render json: @food, status: :created, location: @food }
      else
        format.html { render action: "new" }
        format.json { render json: @food.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /foods/1
  # PUT /foods/1.json
  # def update
  #   @food = Food.find(params[:id])

  #   respond_to do |format|
  #     if @food.update_attributes(params[:food])
  #       format.html { redirect_to @food, notice: 'Food was successfully updated.' }
  #       format.json { head :no_content }
  #     else
  #       format.html { render action: "edit" }
  #       format.json { render json: @food.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # DELETE /foods/1
  # DELETE /foods/1.json
  # def destroy
  #   @food = Food.find(params[:id])
  #   @food.destroy

  #   respond_to do |format|
  #     format.html { redirect_to foods_url }
  #     format.json { head :no_content }
  #   end
  # end
end
