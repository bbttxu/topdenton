class Show < ActiveRecord::Base
  has_many :gigs
  belongs_to :venue
  
  has_many :artists, { :through => :gigs, :order => "position DESC" }
  
  default_scope order("starts_at")
  scope :upcoming, lambda { where("starts_at > ?", Time.zone.now.to_i - 6 * 60 * 60 ) } 
  scope :next_week, lambda { where("starts_at < ?", Time.zone.now.to_i + 7 * 24 * 60 * 60) } 

  scope :after, lambda { |date| where("starts_at > ?", date ) } 
  scope :before, lambda { |date| where("starts_at < ?", date ) } 

  scope :by_day, lambda { group_by{ |u| Time.zone.at(u.starts_at).to_date } }
end
