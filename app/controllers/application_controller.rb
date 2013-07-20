# FIXME
class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :grab_model_counts, :get_current_conditions


  def grab_model_counts
    # TODO move to application!
    @n_shows = Show.all.count
    # @n_artists = Artist.all.count
    # @n_venues = Venue.all.count
  end

  def get_current_conditions
    weather = Weather.current
  end
end
