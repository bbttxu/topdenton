Denton.Views.Shows ||= {}

class Denton.Views.Shows.ShowView extends Backbone.View
  template: JST["backbone/templates/shows/show"]

  # events:
  #   "click .destroy" : "destroy"

  tagName: "div"
  className: "shows_this_day"

  destroy: () ->
    @model.destroy()
    this.remove()

    return false

  render: ->
    $(@el).html(@template(@model.toJSON() ))
    return this
