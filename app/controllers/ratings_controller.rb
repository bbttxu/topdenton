class RatingsController < ApplicationController

  def reorder
    @rated_ids = params[:rated] || []
    @unrated_ids = params[:unrated] || []
    n = 1
    @rated_ids.each do |id|
      rating = Rating.find(id.gsub("rating_", ""))
      rating.rate_and_save n, current_user
      n += 1
    end
    @unrated_ids.each do |id|
      rating = Rating.find(id.gsub("rating_", ""))
      rating.unrate_and_save current_user
    end

    render :json => {}
  end
end
