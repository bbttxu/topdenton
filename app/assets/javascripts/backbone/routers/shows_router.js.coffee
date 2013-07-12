class Denton.Routers.ShowsRouter extends Backbone.Router
  initialize: (options) ->
    @shows = new Denton.Collections.ShowsCollection()
    @shows.reset options.shows

  routes:
    "calendar"      : "calendar"
    "index"    : "index"
    ":id/edit" : "edit"
    ":id"      : "show"
    ".*"        : "index"

  calendar: ->
    @view = new Denton.Views.Shows.CalendarView(collection: @shows)
    $("#shows").html(@view.render().el)

  index: ->
    @view = new Denton.Views.Shows.IndexView(shows: @shows)
    $("#shows").html(@view.render().el)

  show: (id) ->
    show = @shows.get(id)

    @view = new Denton.Views.Shows.ShowView(model: show)
    $("#shows").html(@view.render().el)

  edit: (id) ->
    show = @shows.get(id)

    @view = new Denton.Views.Shows.EditView(model: show)
    $("#shows").html(@view.render().el)
