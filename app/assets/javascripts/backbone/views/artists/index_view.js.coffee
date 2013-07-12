Denton.Views.Artists ||= {}

class Denton.Views.Artists.IndexView extends Backbone.View
  template: JST["backbone/templates/artists/index"]
  # tagName: '#artists'

  initialize: () ->
    @options.artists.bind('reset', @addAll)

  addAll: () =>
    @options.artists.each(@addOne)

  addOne: (artist) =>
    view = new Denton.Views.Artists.ArtistView({model : artist})
    @$("ul").append(view.render().el)

  render: =>
    $(@el).html(@template(artists: @options.artists.toJSON() ))
    @addAll()

    return this
