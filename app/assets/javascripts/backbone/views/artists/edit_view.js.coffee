Denton.Views.Artists ||= {}

class Denton.Views.Artists.EditView extends Backbone.View
  template : JST["backbone/templates/artists/edit"]

  events :
    "submit #edit-artist" : "update"

  update : (e) ->
    e.preventDefault()
    e.stopPropagation()

    @model.save(null,
      success : (artist) =>
        @model = artist
        window.location.hash = "/#{@model.id}"
    )

  render : ->
    $(@el).html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this
