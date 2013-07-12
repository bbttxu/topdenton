Denton.Views.Shows ||= {}

class Denton.Views.Shows.IndexView extends Backbone.View
  template: JST["backbone/templates/shows/index"]

  initialize: () ->
    @options.shows.bind('reset', @addAll)

  addAll: () =>
    @options.shows.each(@addOne)

  addOne: (show) =>
    view = new Denton.Views.Shows.ShowView({model : show})
    @$("tbody").append(view.render().el)

  render: =>
    $(@el).html(@template(shows: @options.shows.toJSON() ))
    @addAll()

    return this
