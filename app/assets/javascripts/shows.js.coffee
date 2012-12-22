# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ = jQuery

### 
call slabText on appropriate elements
run isotope reload()
###
handle_typography_and_layout = ->

	$('ul.shows').each (index, element) ->
		$element = $(element)
		$element.find('li.show').each (i, show_li) ->
			$(show_li).find('div.artists h3').slabText()
			$(show_li).find('div.meta h6').slabText()
		$element.isotope()

$(document).ready(handle_typography_and_layout)
$(document).on('page:load', handle_typography_and_layout)

do_window_resize = null
$(window).resize ->
	do_window_resize = setTimeout ->
		handle_typography_and_layout
	, 100


###
swipe events
beta
###

handle_swipe_event = (event, direction, distance, duration, fingerCount) ->
	if direction == "right"
		path = $('.next a')[0].pathname
		Turbolinks.visit(path)
	if direction == "left"
		path = $('.previous a')[0].pathname
		Turbolinks.visit(path)
	false

options =
	swipeLeft: handle_swipe_event,
	swipeRight: handle_swipe_event

$('#content').swipe(options)

