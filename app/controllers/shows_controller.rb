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
    # @shows = Show.upcoming.next_week
    # @shows.group_by{ |u| Time.zone.at(u.starts_at).to_date.to_datetime.to_i }
    @shows = Show.upcoming.ordered.group_by{|x|Time.zone.parse("#{x.starts_at.to_date} 2:00am")}
    @dates = @shows.collect{|k,v|k}.sort
    @next_show = Show.upcoming.ordered.first
    @prev_show = Show.upcoming.ordered.last

    @calendar = (@next_show.starts_at.beginning_of_week.to_date..@prev_show.starts_at.end_of_month.to_date)
    @calendar = @calendar.each_with_object({}) do |num, hash|
      d = @shows[Time.zone.parse("#{num} 2:00am")]
      hash[num] = 0
      hash[num] = d.count unless d.nil?
    end

    @next_show = nil
    @prev_show = nil


    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @calendar }
    end
  end


  def today
    redirect_to "/shows/#{Time.zone.now.strftime('%F')}"
  end

  def day

    redirect_to '/shows/today', :status => 302 and return if params[:date] == nil
    redirect_to '/shows/today', :status => 302, :alert => "That date was in the past!" and return if Time.zone.now - 1.day > Time.zone.parse( params[:date] )

    @next_show = Show.after(Time.zone.parse( "#{params[:date]} 2:00am" ) + 24.hours).ordered.first
    @prev_show = Show.before(Time.zone.parse( "#{params[:date]} 2:00am" )).ordered.last

    now = Time.zone.parse( "#{params[:date]} 2:00am" )
    tomorrow = now + 24 * 60 * 60
    @now = now
    @shows = Show.after(now).before(tomorrow).ordered

    return if @shows.first == nil

    @gig_dates = Show.ordered.group_by{|x|Time.zone.parse("#{x.starts_at.to_date + 2.hours}") }

    @all_data = []
    @shows.each do |x|
      new_hash = x
      new_hash['venue'] = x.venue
      new_hash['artists'] = []
      x.gigs.each do |gig|
        puts gig.to_json
        # artist_info = name: gig.artist.name
        # artist_info['id'] = gig.artist._id
        # artist_info['name'] = gig.artist.name
        new_hash['artists'] << { name: gig.artist.name }
      end
      puts x.gigs.collect{|x| x.artist.name }.to_yaml
      new_hash['artists'] = x.gigs.collect{|x| x.artist.name }
      @all_data << new_hash
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @all_data }
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
