# FIXME
class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user

  rescue_from CanCan::AccessDenied do |exception|
    url = request.referrer || root_path
    redirect_to url, :notice => exception.message
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
