class Show < ActiveRecord::Base
  has_many :gigs
  belongs_to :venue
  
end
