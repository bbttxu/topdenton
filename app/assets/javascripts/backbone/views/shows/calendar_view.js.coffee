Denton.Views.Shows ||= {}

class Denton.Views.Shows.CalendarView extends Backbone.View
  template: JST["backbone/templates/shows/calendar"]

  tagName: 'li'
  attributes : ()->
    classes = []
    classes.push "count-" + this.model.get( 'gigs' ).length
    day = moment this.model.get 'id'
    # console.log day
    classes.push day.format('ddd').toLowerCase()

    return class: classes.sort().join(" "), id: this.model.get( 'id' )

  # events:
  #   "submit #new-show": "save"

  # constructor: (options) ->
  #   console.log options
  #   super(options)
  #   # console.log  @collection
  #   @model = new @calendar.model options

    # @model.bind("change:errors", () =>
    #   this.render()
    # )

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
    # console.log @model
    $(@el).html(@template(@model.toJSON() ))

    this.$("#shows").backboneLink(@model)

    return this
