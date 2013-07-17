# A gig is played by an artist at a show, it might have a time at some point
class Gig
  include Mongoid::Document
  include Mongoid::Timestamps

  field :position, :type => Integer, :default => 0

  belongs_to :artist
  belongs_to :show
end
