# # FIXME
# class Show < ActiveRecord::Base
#   has_many :gigs
#   belongs_to :venue

#   has_many :artists, { :through => :gigs, :order => "position DESC" }

#   default_scope order("time_is_unknown ASC").order("starts_at")
#   scope :upcoming, lambda { where("starts_at > ?", Time.zone.now.to_i - 0 * 60 * 60 ) }
#   scope :next_week, lambda { where("starts_at < ?", Time.zone.now.to_i + 7 * 24 * 60 * 60) }

#   scope :after, lambda { |date| where("starts_at > ?", date ) }
#   scope :before, lambda { |date| where("starts_at < ?", date ) }

#   scope :by_day, lambda { group_by{ |u| Time.zone.at(u.starts_at).to_date } }

#   # def to_s
#   #   "#{self.id}"
#   # end
# end

class Show
  include MongoMapper::Document
  plugin MongoMapper::Plugins::IdentityMap

  # key :name, String, :required => true
  key :price, String, :required => true, :default => "?"
  key :source, String, :required => true
  key :doors_at, Time
  key :starts_at, Time, :required => true
  # key :ends_at, DateTime, :required => true
  key :time_is_unknown, Boolean, :required => true

  belongs_to :venue, :require => true
  many :gigs

  scope :after, lambda { |date| where(:starts_at.gte => date.localtime ) }
  scope :before, lambda { |date| where(:starts_at.lte => date.localtime ) }
  scope :upcoming, lambda { where(:starts_at.gte => Time.zone.now ) }

end