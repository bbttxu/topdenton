# A venue is a location
class Venue
  include MongoMapper::Document
  plugin MongoMapper::Plugins::IdentityMap

  key :name, String, :required => true
  key :phone, String, :required => true
  key :address, String, :required => true

  many :shows
end