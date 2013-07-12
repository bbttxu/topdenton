Denton.Views.Shows ||= {}

class Denton.Views.Shows.EditView extends Backbone.View
  template : JST["backbone/templates/shows/edit"]

  events :
    "submit #edit-show" : "update"

  update : (e) ->
    e.preventDefault()
    e.stopPropagation()

    @model.save(null,
      success : (show) =>
        @model = show
        window.location.hash = "/#{@model.id}"
    )

  render : ->
    $(@el).html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this
