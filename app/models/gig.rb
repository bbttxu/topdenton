# # FIXME
# class Gig < ActiveRecord::Base
#   belongs_to :artist
#   belongs_to :show

#   # def self.to_s
#   #   self.artist.name
#   # end
# end

class Gig
  include MongoMapper::Document
  plugin MongoMapper::Plugins::IdentityMap

  key :position, :default => 0

  belongs_to :artist
  belongs_to :show

  # def self.to_s
  #   self.artist.name
  # end
end
