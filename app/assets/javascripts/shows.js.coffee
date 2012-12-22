# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ = jQuery

handle_typography_and_layout = ->
	$('ul.shows li').each (index, element) ->
		$(element).find('div.artists h3').slabText()
		$(element).find('div.meta h6').slabText()
	$('ul.shows').isotope()

$(document).ready(handle_typography_and_layout)
$(document).on('page:load', handle_typography_and_layout)

doet = null
$(window).resize ->
	doet = setTimeout ->
		handle_typography_and_layout
	, 100

