
class ShowSerializer < ActiveModel::Serializer
  attributes :id, :starts_at, :source

  # has_many :artists, serializer: ArtistSerializer, embed: :ids, include: true, key: :artists

  has_many :gigs, serializer: GigSerializer, embed: :ids, include: true, key: :gigs

end
