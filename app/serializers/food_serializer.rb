
class FoodSerializer < ActiveModel::Serializer
  attributes :id, :name, :tags_array, :coordinates, :full_address

  # has_many :gigs, serializer: GigSerializer, embed: :ids, include: true, key: :gigs
  # has_one :venue, serializer: VenueSerializer, embed: :ids, include: true, key: :venues
end
