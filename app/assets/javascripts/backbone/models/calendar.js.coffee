class Denton.Models.Calendar extends Backbone.Model
  paramRoot: 'calendar'

  defaults:
    id: "idk"
    gigs: []

  # hello: ()->
  #   this.model.count

class Denton.Collections.CalendarsCollection extends Backbone.Collection
  model: Denton.Models.Calendar
  url: '/calendars'
