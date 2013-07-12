# FIXME
class ArtistsController < ApplicationController
  # GET /artists
  # GET /artists.json
  def index
    # @artists = Artist.group_by do |u|
    #   u.name
    # end
    @artists = Artist.alphabetical.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @artists }
    end
  end

  # GET /artists/1
  # GET /artists/1.json
  def show
    @artist = Artist.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @artist }
    end
  end
end
