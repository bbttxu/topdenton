class Show < ActiveRecord::Base
  has_many :gigs
  belongs_to :venue
  
  has_many :artists, :through => :gigs
  
  default_scope order("starts_at")
  scope :upcoming, lambda { where("starts_at < ?", Time.zone.now.to_i + 7 * 24 * 60 * 60) } 
end
