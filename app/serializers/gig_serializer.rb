class GigSerializer < ActiveModel::Serializer
  attributes :id, :position

  has_one :artist, serializer: ArtistSerializer, embed: :ids, include: true, key: :artists

end
