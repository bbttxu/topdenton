class Denton.Models.Show extends Backbone.Model
  paramRoot: 'show'

  defaults: {}

class Denton.Collections.ShowsCollection extends Backbone.Collection
  model: Denton.Models.Show
  url: '/shows'
