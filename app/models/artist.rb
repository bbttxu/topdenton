class Artist < ActiveRecord::Base
  has_many :gigs
  has_many :shows, :through => :gigs
  
  default_scope order("name")
end
