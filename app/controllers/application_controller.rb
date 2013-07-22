# FIXME
class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :grab_model_counts, :get_current_conditions
  helper_method :current_user

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end

  def grab_model_counts
    # TODO move to application!
    @n_shows = Show.all.count
    # @n_artists = Artist.all.count
    # @n_venues = Venue.all.count
  end

  def get_current_conditions
    weather = Weather.current
  end

  private
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
end
