class Show < ActiveRecord::Base
  has_many :gigs
  belongs_to :venue
  
  def self.to_s
    "woohoo"
  end
end
