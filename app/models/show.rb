# a show is an event with one or more artists which takes place at a venue
class Show
  include Mongoid::Document
  include Mongoid::Timestamps

  field :price, :type => String, :default => "?"
  field :source, :type => String
  field :doors_at, :type => Time
  field :starts_at, :type => Time
  field :time_is_unknown, :type => Boolean

  belongs_to :venue
  has_many :gigs
  has_many :artists #, :through => :gigs

  scope :after, lambda { |date| where(:starts_at.gte => date.localtime ) }
  scope :before, lambda { |date| where(:starts_at.lte => date.localtime ) }
  scope :upcoming, lambda { where( :starts_at.gte => Time.zone.now ) }
  scope :ordered, order_by( :starts_at => :asc )

  validates_presence_of :price, :source, :starts_at, :time_is_unknown
end