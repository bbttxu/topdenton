class Denton.Models.Calendar extends Backbone.Model
  paramRoot: 'calendar'

  defaults:
    count: 0
    id: "idk"

  # hello: ()->
  #   this.model.count

class Denton.Collections.CalendarsCollection extends Backbone.Collection
  model: Denton.Models.Calendar
  url: '/calendars'
