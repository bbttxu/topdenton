Denton.Views.Artists ||= {}

class Denton.Views.Artists.ArtistView extends Backbone.View
  template: JST["backbone/templates/artists/artist"]

  events:
    "click .destroy" : "destroy"

  tagName: "li"

  destroy: () ->
    @model.destroy()
    this.remove()

    return false

  render: ->
    $(@el).html(@template(@model.toJSON() ))
    return this
