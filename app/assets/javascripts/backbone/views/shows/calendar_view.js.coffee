Denton.Views.Shows ||= {}

class Denton.Views.Shows.CalendarView extends Backbone.View
  template: JST["backbone/templates/shows/calendar"]

  # events:
  #   "submit #new-show": "save"

  constructor: (options) ->
    super(options)
    @model = new @collection.model()

    @model.bind("change:errors", () =>
      this.render()
    )

  # save: (e) ->
  #   e.preventDefault()
  #   e.stopPropagation()

  #   @model.unset("errors")

  #   @collection.create(@model.toJSON(),
  #     success: (show) =>
  #       @model = show
  #       window.location.hash = "/#{@model.id}"

  #     error: (show, jqXHR) =>
  #       @model.set({errors: $.parseJSON(jqXHR.responseText)})
  #   )

  render: ->
    console.log @model
    $(@el).html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this
