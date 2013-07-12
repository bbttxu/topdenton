Denton.Views.Shows ||= {}

class Denton.Views.Shows.NewView extends Backbone.View
  template: JST["backbone/templates/shows/new"]

  events:
    "submit #new-show": "save"

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
      success: (show) =>
        @model = show
        window.location.hash = "/#{@model.id}"

      error: (show, jqXHR) =>
        @model.set({errors: $.parseJSON(jqXHR.responseText)})
    )

  render: ->
    $(@el).html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this
