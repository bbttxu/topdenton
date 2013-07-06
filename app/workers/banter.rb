#!/usr/bin/env ruby -wKU
require 'rubygems'
require 'open-uri'
require 'nokogiri'
require 'chronic'
# require 'ri_cal'
# require 'httparty'

# class Banter < Scraper
#   @queue = :banter
#   def self.perform()
#     puts "updating banter"
#
#     banter = Venue.find_or_create_by_name "Dan's Silverleaf"
#     banter.phone = "9403202000"
#     banter.address = "103 Industrial Street, Denton, TX 76201-4223"
#     banter.save
#     shows = Show.delete_all :venue_id => banter.id
#
#
#
#
#     url = "https://www.google.com/calendar/ical/dentonbanter%40gmail.com/public/basic.ics"
#     response = HTTParty.get(url).response
#     puts response
#   end
# end