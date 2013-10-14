class Denton.Routers.ShowRouter extends Backbone.Router
  initialize: (options) ->
    @shows = new Denton.Collections.Shows()
    @shows.reset options.shows

    @calendar = new Denton.Collections.CalendarsCollection()
    @calendar.reset options.dates

  routes:
    # "new"      : "newShow"
    "index"    : "index"
    # ":id/edit" : "edit"
    ":id"      : "show"
    ".*"        : "index"

  # newShow: ->
  #   @view = new Denton.Views.Shows.NewView(collection: @shows)
  #   $("#shows").html(@view.render().el)

  index: ->
    @view = new Denton.Views.Shows.IndexView(shows: @shows)
    $("#shows").html(@view.render().el)

  show: (id) ->
    show = @calendar.get(id)
    console.log show

    @view = new Denton.Views.Shows.ShowView(model: show)

    sunday = $("a.active").parent().nextAll('li.sun').first()
    sunday = $("a.active").parent() if $("li.sun a.active")[0]
    sunday.after(@view.render().el)

  # edit: (id) ->
  #   show = @shows.get(id)

  #   @view = new Denton.Views.Shows.EditView(model: show)
  #   $("#shows").html(@view.render().el)


