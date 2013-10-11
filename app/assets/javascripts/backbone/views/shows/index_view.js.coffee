Denton.Views.Shows ||= {}

class Denton.Views.Shows.IndexView extends Backbone.View
  template: JST["backbone/templates/shows/index"]

  initialize: () ->
    # _.bind('all',this);
    @options.dates.bind('reset', @addAll)

  addAll: () =>
    @options.dates.each(@addOne)

  addOne: (show) =>
    # view = new Denton.Views.Shows.ShowView({model : show})
    # view = new Denton.Views.Shows.CalendarView({model : show})
    # @$("#asdf").append(view.render().el)

  render: =>
    console.log @options
    $(@el).html(@template(calendar: @options.calendar.toJSON() ))
    @addAll()

    return this
