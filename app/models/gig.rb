class Gig < ActiveRecord::Base  
  belongs_to :artist
  belongs_to :show  
  
  # def self.to_s
  #   self.artist.name
  # end
end
