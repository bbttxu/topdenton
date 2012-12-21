# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ = jQuery

handle_typography = ->
	$('ul.shows li').each (index, element) ->
		$(element).find('div.artists h3').slabText()
		$(element).find('div.meta h6').slabText()


doet = null
handle_typography_and_layout = ->
	clearTimeout(doet)
	doet = setTimeout ->
		handle_typography()
		$('ul.shows').isotope()
		# console.log "fired!"
	, 100


# function() {
#     clearTimeout(doit);
#     doit = setTimeout(function() {
#         resizedw();
#     }, 100);

$(document).ready(handle_typography_and_layout)
$(document).on('page:load', handle_typography_and_layout)

$(window).resize( handle_typography_and_layout )