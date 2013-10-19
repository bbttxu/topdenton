Denton.Views.Shows ||= {}

class Denton.Views.Shows.IndexView extends Backbone.View
  template: JST["backbone/templates/shows/index"]

  id: 'shows-calendar'
  tagName: 'div'

  initialize: () ->
    @options.calendar.bind 'reset', @addAll

  addAll: () =>
    @options.calendar.each @addOne

  addOne: (calendar) =>
    # view = new Denton.Views.Shows.ShowView({model : show})
    view = new Denton.Views.Shows.CalendarView({model : calendar})
    # console.log view.render().el
    @$("ul#shows").append(view.render().el)

  render: =>
    # console.log @options
    $(@el).html(@template(calendar: @options.calendar.toJSON() ))
    @addAll()

    return this
