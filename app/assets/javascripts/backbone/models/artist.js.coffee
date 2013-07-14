
class Denton.Models.Artist extends Backbone.Model
  paramRoot: 'artist'

  defaults:
    name: "no name given"

  initialize: ->
    # @shows = new Denton.Collections.ShowsCollection()
    # gigs_attributes: ->
    #   @shows.map (p) ->
    #     {show_id: p.get("id")}

class Denton.Collections.ArtistsCollection extends Backbone.Collection
  model: Denton.Models.Artist
  url: '/artists'
