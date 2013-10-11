Denton.Views.Calendars ||= {}

class Denton.Views.Calendars.IndexView extends Backbone.View
  template: JST["backbone/templates/calendars/index"]

  initialize: () ->
    @options.calendars.bind('reset', @addAll)

  addAll: () =>
    @options.calendars.each(@addOne)

  addOne: (calendar) =>
    view = new Denton.Views.Calendars.CalendarView({model : calendar})
    @$("#calendar-items").append(view.render().el)

  render: =>
    $(@el).html(@template(calendars: @options.calendars.toJSON() ))
    @addAll()

    return this
