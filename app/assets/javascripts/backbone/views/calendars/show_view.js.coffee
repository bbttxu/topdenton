Denton.Views.Calendars ||= {}

class Denton.Views.Calendars.ShowView extends Backbone.View
  template: JST["backbone/templates/calendars/show"]

  render: ->
    $(@el).html(@template(@model.toJSON() ))
    return this
