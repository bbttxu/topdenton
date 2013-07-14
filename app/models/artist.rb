# An artist or band
class Artist
  include MongoMapper::Document
  plugin MongoMapper::Plugins::IdentityMap
  # plugin MongoMapper::AcceptsNestedAttributes

  key :name, String

  many :gigs
  # many :shows, :through => :gigs

  def as_json(options = nil)
    super((options || {}).merge(include: { gigs: { only: ["show_id"] } } ))
  end

  # accepts_nested_attributes_for :gigs

  scope :alphabetical, sort("name")
end
