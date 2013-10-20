Denton.Views.Shows ||= {}

class Denton.Views.Shows.IndexView extends Backbone.View
  template: JST["backbone/templates/shows/index"]

  id: 'shows-calendar'
  tagName: 'div'
  className: 'row'

  initialize: () ->
    console.log this.collection
    @options.calendar.bind 'reset', @addAll

  addAll: () =>
    dates = @options.calendar.each (i)->
      i.id
    
    @options.calendar.each @addOne

  addOne: (calendar) =>
    view = new Denton.Views.Shows.CalendarView({model : calendar})
    
    @$("ul#shows").append(view.render().el).each ()->
    $( '#' + calendar.id ).slideUp().slideDown()      

  render: =>
    $(@el).html(@template(calendar: @options.calendar.toJSON() ))
    @addAll()

    return this

  animate: ( element )->
    $( '#' + element ).slideUp().slideDown() 
