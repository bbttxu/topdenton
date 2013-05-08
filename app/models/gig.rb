# A gig is played by an artist at a show, it might have a time at some point
class Gig
  include MongoMapper::Document
  plugin MongoMapper::Plugins::IdentityMap

  key :position, :default => 0

  belongs_to :artist
  belongs_to :show
end
