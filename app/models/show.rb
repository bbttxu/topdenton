# a show is an event with one or more artists which takes place at a venue
class Show
  include MongoMapper::Document
  plugin MongoMapper::Plugins::IdentityMap

  key :price, String, :required => true, :default => "?"
  key :source, String, :required => true
  key :doors_at, Time
  key :starts_at, Time, :required => true
  key :time_is_unknown, Boolean, :required => true

  belongs_to :venue, :require => true
  many :gigs
  many :artists, :through => :gigs

  scope :after, lambda { |date| where(:starts_at.gte => date.localtime ) }
  scope :before, lambda { |date| where(:starts_at.lte => date.localtime ) }
  scope :upcoming, lambda { where(:starts_at.gte => Time.zone.now ) }
  scope :ordered, order("starts_at")

end