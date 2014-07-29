class FoodsController < ApplicationController

  skip_before_filter :authenticate_user!

  load_and_authorize_resource


  # GET /foods
  # GET /foods.json
  def index

    longitude = params[:longitude].to_f || -97.1248875
    latitude = params[:latitude].to_f || 33.1997146
    distance = params[:distance].to_f || 10

    # FIXME the 0.008 multiplier was taken from on-line, needs to be checked
    @foods = Food.geo_near([longitude, latitude]).max_distance( distance * 0.008 )

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

  # GET /foods/1/rate
  # GET /foods/1.json
  # NB id is tag name for a Rating, not an id
  def landing
    @tags = Rating.tags_with_weight.sort_by{|x|[-x[1],x[0]]}
    @randomTag = @tags[rand(@tags.length)][0]
    @tag = Rating.tagged_with(@randomTag).top_one.first
    @food = @tag.food

    respond_to do |format|
      format.html # show.html.erb
      # format.json { render json: @rated }
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
  def update
    @food = Food.find(params[:id])

    respond_to do |format|
      if @food.update_attributes(params[:food])
        format.html { redirect_to @food, notice: 'Food was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @food.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /foods/1
  # DELETE /foods/1.json
  def destroy
    @food = Food.find(params[:id])
    @food.destroy

    respond_to do |format|
      format.html { redirect_to foods_url }
      format.json { head :no_content }
    end
  end
end
