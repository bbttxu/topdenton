# FIXME
class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :grab_model_counts, :get_current_conditions, :authenticate_user!
  helper_method :current_user

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to request.referrer, :notice => exception.message
  end

  def grab_model_counts
    # TODO move to application!
    @n_shows = Show.all.count
    # @n_foods = Food.all.count
    # @n_artists = Artist.all.count
    # @n_venues = Venue.all.count
  end

  def get_current_conditions
    weather = Weather.current
  end

  private
  def current_user
    begin
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
    rescue Mongoid::Errors::DocumentNotFound
      nil
    end
  end

  def user_signed_in?
    return true if current_user
  end

  def correct_user?
    @user = User.find(params[:id])
    unless current_user == @user
      redirect_to request.referer, :alert => "Access denied."
    end
  end

  def authenticate_user!
    if !current_user
      redirect_to root_path, :alert => 'You need to sign in for access to this page.'
    end
  end
end
