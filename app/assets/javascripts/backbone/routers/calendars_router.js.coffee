class Denton.Routers.CalendarsRouter extends Backbone.Router
  initialize: (options) ->
    # console.log options
    @calendars = new Denton.Collections.CalendarsCollection()
    @calendars.reset options.calendars


  routes:
    "new"      : "newCalendar"
    "index"    : "index"
    ":id/edit" : "edit"
    ":id"      : "show"
    ".*"        : "index"

  newCalendar: ->
    @view = new Denton.Views.Calendars.NewView(collection: @calendars)
    $("#calendars").html(@view.render().el)

  index: ->
    @view = new Denton.Views.Calendars.IndexView(calendars: @calendars)
    $("#calendar").html(@view.render().el)

  show: (id) ->
    calendar = @calendars.get(id)

    @view = new Denton.Views.Calendars.ShowView(model: calendar)
    $("#calendars").html(@view.render().el)

  edit: (id) ->
    calendar = @calendars.get(id)

    @view = new Denton.Views.Calendars.EditView(model: calendar)
    $("#calendars").html(@view.render().el)


# class Denton.Routers.CalendarRouter extends Backbone.Router
#   initialize: (options) ->
#     console.log options
#     @shows = new Denton.Collections.Calendar()
#     @shows.reset options.shows

#   routes:
#     ".*"        : "index"

#   index: ->
#     @view = new Denton.Views.Shows.IndexView(shows: @shows)
#     $("#calendar").html(@view.render().el)

