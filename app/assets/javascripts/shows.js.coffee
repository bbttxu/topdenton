# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ = jQuery

###
  _________.__        ___. ___________              __
 /   _____/|  | _____ \_ |_\__    ___/___ ___  ____/  |_
 \_____  \ |  | \__  \ | __ \|    |_/ __ \\  \/  /\   __\
 /        \|  |__/ __ \| \_\ \    |\  ___/ >    <  |  |
/_______  /|____(____  /___  /____| \___  >__/\_ \ |__|
        \/           \/    \/           \/      \/
call slabText on appropriate elements
run isotope reload()
###
do_window_resize = null
handle_typography_and_layout = ->
  # $('#artists-listing li h3').slabText()
  # $('#next h3, #prev h3, h3.date').slabText()
  # $('#artists-listing').isotope()

  # $('ul.shows').each (index, element) ->
  #   $element = $(element)
    # $element.find('li').each (i, show_li) ->
    #   # $(show_li).find('div.artists h3').slabText()
    #   # $(show_li).find('div.meta h6').slabText()
    # $element.isotope('reLayout')
  $('ul.shows').isotope({})

$(document).ready( handle_typography_and_layout )
# $(document).on('page:load', handle_typography_and_layout)

$(window)._scrollable()

$(window).resize ->
  do_window_resize = setTimeout ->
    handle_typography_and_layout()
  , 100



handle_calendar_click = (event)->
  has_active_class = $(this).hasClass 'active'

  $('.active').toggleClass 'active'
  if has_active_class
    $( 'div.shows_this_day' ).slideToggle 100, ()->
      $.scrollTo( $('#page'), 300)


  unless has_active_class
    $(this).toggleClass 'active'
    $( 'div.shows_this_day' ).slideToggle 100, ()->
      $next = 'max'
      $next = $('.shows_this.day').next('li') if $('.shows_this.day').next('li')
      $.scrollTo( $next, 300)

  # if has_active_class
  # console.log event
  # event.preventDefault()
  # console.log event


$(document).ready ()->
  $('#calendar li a').on 'click', handle_calendar_click
  # $('#calendar li a.active').click handle_calendar_click

  # unless ( $('#calendar li a.active').length == 0 )
  #   console.log "do something else"


###
___________                   .__    ___ ___         .__       .__     __
\_   _____/ ________ _______  |  |  /   |   \   ____ |__| ____ |  |___/  |_  ______
 |    __)_ / ____/  |  \__  \ |  | /    ~    \_/ __ \|  |/ ___\|  |  \   __\/  ___/
 |        < <_|  |  |  // __ \|  |_\    Y    /\  ___/|  / /_/  >   Y  \  |  \___ \
/_______  /\__   |____/(____  /____/\___|_  /  \___  >__\___  /|___|  /__| /____  >
        \/    |__|          \/            \/       \/  /_____/      \/          \/
###

# do_equal_heights = null
# handle_equal_heights = ->
#   calendar = $('#calendar')
#   content = $('#content')
#   calendar.outerHeight( content.outerHeight() )

# $(document).ready(handle_equal_heights)
# $(document).on('page:load', handle_equal_heights)

# $(window).resize ->
#   do_equal_heights = setTimeout ->
#     handle_equal_heights
#   , 100


###
swipe events
beta
###

# handle_swipe_event = (event, direction, distance, duration, fingerCount) ->
#   if direction == "right"
#     path = $('.next a')[0].pathname
#     Turbolinks.visit(path)
#   if direction == "left"
#     path = $('.previous a')[0].pathname
#     Turbolinks.visit(path)
#   false

# options =
#   swipeLeft: handle_swipe_event,
#   swipeRight: handle_swipe_event

# $('#content').swipe(options)

#

$(document).ready ()->
  $.bind '*', (event)->
    console.log event

