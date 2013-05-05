# FIXME
class ShowsController < ApplicationController
  # GET /shows
  # GET /shows.json
  def index
    @shows = Show.upcoming.next_week.group_by{ |u| Time.zone.at(u.starts_at).to_date.to_datetime.to_i }

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @shows }
    end
  end


  def today
    redirect_to "/shows/#{Time.now.strftime('%F')}"
  end

  def day

    expires_in 5.minutes, :public => true

    redirect_to '/shows/today', :status => 302 and return if params[:date] == nil


    now = Time.zone.parse( "#{params[:date]} 2:00am" )
    tomorrow = now + 24 * 60 * 60
    @now = now
    @shows = Show.after(now).before(tomorrow)

    # @show = @shows.first unless @shows.first == nil
    return if @shows.first == nil
    # @next_show = Show.after(tomorrow.to_i).order("starts_at ASC").first
    # @most_recent_show = Show.before(now.to_i).upcoming.reverse.first


    @gig_dates = Show.all.group_by{|x|x.starts_at}
    @gig_dates = Show.all.group_by{|x|Time.zone.parse("#{x.starts_at} 2:00am")}# @upcoming_shows = @shows.keys
    # @gig_dates.collect
    # @shows = @shows.first
    # expires_in 5.seconds, :public => true

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @shows }
    end
  end


  # GET /shows/1
  # GET /shows/1.json
  def show
    @show = Show.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @show }
    end
  end

  # # GET /shows/new
  # # GET /shows/new.json
  # def new
  #   @show = Show.new
  #
  #   respond_to do |format|
  #     format.html # new.html.erb
  #     format.json { render json: @show }
  #   end
  # end
  #
  # # GET /shows/1/edit
  # def edit
  #   @show = Show.find(params[:id])
  # end
  #
  # # POST /shows
  # # POST /shows.json
  # def create
  #   @show = Show.new(params[:show])
  #
  #   respond_to do |format|
  #     if @show.save
  #       format.html { redirect_to @show, notice: 'Show was successfully created.' }
  #       format.json { render json: @show, status: :created, location: @show }
  #     else
  #       format.html { render action: "new" }
  #       format.json { render json: @show.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end
  #
  # # PUT /shows/1
  # # PUT /shows/1.json
  # def update
  #   @show = Show.find(params[:id])
  #
  #   respond_to do |format|
  #     if @show.update_attributes(params[:show])
  #       format.html { redirect_to @show, notice: 'Show was successfully updated.' }
  #       format.json { head :ok }
  #     else
  #       format.html { render action: "edit" }
  #       format.json { render json: @show.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end
  #
  # # DELETE /shows/1
  # # DELETE /shows/1.json
  # def destroy
  #   @show = Show.find(params[:id])
  #   @show.destroy
  #
  #   respond_to do |format|
  #     format.html { redirect_to shows_url }
  #     format.json { head :ok }
  #   end
  # end
end
