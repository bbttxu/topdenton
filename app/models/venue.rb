# A venue is a location
class Venue
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, :type => String
  field :phone, :type => String
  field :address, :type => String

  validates_presence_of :name, :phone, :address

  has_many :shows
end