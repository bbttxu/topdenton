class CalendarsController < ApplicationController

  skip_before_filter :authenticate_user!, only: [ :index ]
  # before_filter :do_caching


  # GET /calendars
  # GET /calendars.json

  def index
    @shows = Show.upcoming.ordered.group_by{|x|Time.zone.parse("#{x.starts_at.to_date} 2:00am")}
    @dates = @shows.collect{|k,v|k}.sort
    @next_show = Show.upcoming.ordered.first
    @prev_show = Show.upcoming.ordered.last

    @calendars = []

    @calendar = (@next_show.starts_at.beginning_of_week.to_date..@prev_show.starts_at.end_of_month.to_date)
    @calendar = @calendar.each do |thing|
      d = @shows[Time.zone.parse("#{thing} 2:00am")]
      value = 0
      value = d.count unless d.nil?

      some_hash = {}
      some_hash[thing.strftime('%F')] = { id: thing.strftime('%F'), count: value }

      @calendars << { id: thing.strftime('%F'), count: value }
    end

    puts @calendars.to_json

    @next_show = nil
    @prev_show = nil


    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @calendars }
    end
  end

end