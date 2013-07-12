Denton.Views.Artists ||= {}

class Denton.Views.Artists.NewView extends Backbone.View
  template: JST["backbone/templates/artists/new"]

  events:
    "submit #new-artist": "save"

  constructor: (options) ->
    super(options)
    @model = new @collection.model()

    @model.bind("change:errors", () =>
      this.render()
    )

  save: (e) ->
    e.preventDefault()
    e.stopPropagation()

    @model.unset("errors")

    @collection.create(@model.toJSON(),
      success: (artist) =>
        @model = artist
        window.location.hash = "/#{@model.id}"

      error: (artist, jqXHR) =>
        @model.set({errors: $.parseJSON(jqXHR.responseText)})
    )

  render: ->
    $(@el).html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this
