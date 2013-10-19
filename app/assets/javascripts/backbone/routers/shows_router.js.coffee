class Denton.Routers.ShowRouter extends Backbone.Router
  initialize: (options) ->
    # console.log options.shows

    gigs = gig.id for gig in options.shows

    calendar = _.groupBy options.shows, (item)->
      day = moment(item.starts_at).format("YYYY-MM-DD")


    all_of_thems = []

    _.map calendar, (key, value, item)->
      # ids =

      day =
        id: value
        gigs: _.map item[value], (key, value, gig )->
          gig[value].id

      all_of_thems.push day


    options.calendar = all_of_thems
    # console.log all_of_thems
    # console.log options.shows

    @shows = new Denton.Collections.Shows()
    @shows.reset options.shows



    @calendar = new Denton.Collections.CalendarsCollection()
    @calendar.reset options.calendar

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
    @view = new Denton.Views.Shows.IndexView calendar: @calendar
    $("#page").append(@view.render().el)

  show: (id) ->
    # console.log id
    show = @shows.fetch( id )
    # console.log show
    # console.log gig for gig in show.gigs

    @view = new Denton.Views.Shows.ShowView model: show

    sunday = $("a.active").parent().nextAll('li.sun').first()
    sunday = $("a.active").parent() if $("li.sun a.active")[0]
    $('div.shows_this_day').remove()
    sunday.after(@view.render().el)

  # edit: (id) ->
  #   show = @shows.get(id)

  #   @view = new Denton.Views.Shows.EditView(model: show)
  #   $("#shows").html(@view.render().el)


