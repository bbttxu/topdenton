# FIXME
class ShowsController < ApplicationController
  # GET /shows
  # GET /shows.json
  def index
    @shows = Show.upcoming.next_week
    @shows.group_by{ |u| Time.zone.at(u.starts_at).to_date.to_datetime.to_i }

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

    return if @shows.first == nil

    @gig_dates = Show.ordered.group_by{|x|Time.zone.parse("#{x.starts_at.to_date} 2:00am")}

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
end
