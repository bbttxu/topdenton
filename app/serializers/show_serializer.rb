
class ShowSerializer < ActiveModel::Serializer
  attributes :id, :starts_at, :source, :time_is_unknown, :price

  # has_many :artists, serializer: ArtistSerializer, embed: :ids, include: true, key: :artists

  has_many :gigs, serializer: GigSerializer, embed: :ids, include: true, key: :gigs
  has_one :venue, serializer: VenueSerializer, embed: :ids, include: true, key: :venues
end
