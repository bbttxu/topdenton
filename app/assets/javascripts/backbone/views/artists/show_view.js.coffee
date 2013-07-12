Denton.Views.Artists ||= {}

class Denton.Views.Artists.ShowView extends Backbone.View
  template: JST["backbone/templates/artists/show"]

  render: ->
    $(@el).html(@template(@model.toJSON() ))
    return this
