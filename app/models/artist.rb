# An artist or band
class Artist
  include MongoMapper::Document
  plugin MongoMapper::Plugins::IdentityMap
  plugin MongoMapper::AcceptsNestedAttributes

  key :name, String

  many :gigs
  many :shows, :through => :gigs

  accepts_nested_attributes_for :gigs

  scope :alphabetical, sort("name")
end
