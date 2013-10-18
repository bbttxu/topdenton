class Denton.Models.Show extends Backbone.Model
  paramRoot: 'shows'

  defaults:
    price: null
    source: null
    starts_at: null
    ends_at: null

class Denton.Collections.Shows extends Backbone.Collection
  model: Denton.Models.Show
  paramRoot: 'shows'

  url: ()->
    console.log this
    url = if this.id then '/shows/' + this.id else '/shows'
    console.log url
    url


  parse: (response) =>
    @entries = response.shows
    response.shows



# # app/assets/javascripts/collections/feeds.coffee
# class @Denton.Collections.Shows extends Backbone.Collection
#   model: Denton.Models.Show
#   url: '/shows'
#   parse: (response) =>
#     @entries = response.shows
#     response.shows

# # app/assets/javascripts/collections/feeds.coffee
# class @Denton.Collections.Calendar extends Backbone.Collection
#   model: Denton.Models.Calendar
#   url: '/shows'

#   parse: (response) =>
#     @entries = response.shows
#     response.shows