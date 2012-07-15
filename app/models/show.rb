class Show < ActiveRecord::Base
  has_many :gigs
  belongs_to :venue
  
  has_many :artists, :through => :gigs
  
  default_scope order("starts_at")
end
