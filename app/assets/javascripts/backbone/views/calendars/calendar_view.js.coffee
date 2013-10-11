Denton.Views.Calendars ||= {}

class Denton.Views.Calendars.CalendarView extends Backbone.View
  template: JST["backbone/templates/calendars/calendar"]

  # initialize: ()->
  #   _.bindAll(this, 'className')

  events:
    "click .destroy" : "destroy"

  tagName: "li"
  # className: "count-" + @model.count

  destroy: () ->
    @model.destroy()
    this.remove()

    return false

  render: ->
    $(@el).html(@template(@model.toJSON() ))
    return this
