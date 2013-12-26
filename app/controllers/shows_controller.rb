# FIXME
class ShowsController < ApplicationController
  # GET /shows
  # GET /shows.json
  skip_before_filter :authenticate_user!, only: [ :index, :show, :day, :today ]
  before_filter :do_caching

  def do_caching
    expires_in 15.minutes, :public => true
  end

  def index
    @shows = Show.upcoming.ordered

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @shows, :callback => params[:callback] }
    end
  end

  def day
    now = Time.zone.parse( "#{params[:date]} 2:00am" )
    tomorrow = now + 24 * 60 * 60
    @shows = Show.after(now).before(tomorrow).ordered

    respond_to do |format|
      format.json { render json: @shows, callback: params[:callback] }
    end
  end
end
