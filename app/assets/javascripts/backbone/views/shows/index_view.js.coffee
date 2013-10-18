Denton.Views.Shows ||= {}

class Denton.Views.Shows.IndexView extends Backbone.View
  template: JST["backbone/templates/shows/index"]

  initialize: () ->
    @options.calendar.bind 'reset', @addAll

  addAll: () =>
    @options.calendar.each @addOne

  addOne: (calendar) =>
    console.log calendar
    # view = new Denton.Views.Shows.ShowView({model : show})
    view = new Denton.Views.Shows.CalendarView({model : calendar})
    @$("#shows").append(view.render().el)

  render: =>
    # console.log @options
    $(@el).html(@template(calendar: @options.calendar.toJSON() ))
    @addAll()

    return this
