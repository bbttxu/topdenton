class Denton.Models.Artist extends Backbone.Model
  paramRoot: 'artist'

  defaults:
    name: null

class Denton.Collections.ArtistsCollection extends Backbone.Collection
  model: Denton.Models.Artist
  url: '/artists'
