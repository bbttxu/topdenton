# FIXME
class GigsController < ApplicationController
  # GET /gigs
  # GET /gigs.json
  def index
    @gigs = Gig.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @gigs }
    end
  end

  # GET /gigs/1
  # GET /gigs/1.json
  def show
    @gig = Gig.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @gig }
    end
  end
end
