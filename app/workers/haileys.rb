#!/usr/bin/env ruby -wKU
require 'rubygems'
require 'open-uri'
require 'nokogiri'
require 'chronic'

# worker to scrape data from the following venue
class Haileys < Scraper
  @queue = :haileys

  def self.perform()
    puts "updating Hailey's"

    haileys = Venue.find_or_create_by_name "Hailey's Club"
    haileys.phone = "(940) 323-1159"
    haileys.address = "122 Mulberry Street, Denton, TX"
    haileys.save


    html = Nokogiri::HTML( open( 'http://haileysclub.com/contact/' ) )
    shows = Show.delete_all :venue_id => haileys.id

    shows_url = "http://haileysclub.com/calendar/"
    fetched_doc = Nokogiri::HTML( open( shows_url ) )
    doc = fetched_doc.to_html

    doc = Nokogiri::HTML(doc)

    doc.css("div.show").each do |show|
      bands = show.css('div.band')

      time = show.at_css('ul.event-info li:first')
      event_info = show.css('ul.event-info li')
      price = Nokogiri::HTML( event_info[1].to_s ).text

      unless time.nil?
        time = time ? time.text : 'Doors at 1:23PM,'
        time.gsub!('Doors at','').gsub!(',','')
      end

      date = show.at_css('span.date-display-single')
      date = date ? date.text.split('-')[1] : '12.12'
      date.gsub!('.','/')
      parts = date.split('/')
      month = parts[0]
      month = Date::MONTHNAMES[month.to_i]
      date_of_month = parts[1]
      date = month + " " + date_of_month
      time = show.css('ul.event-info li:first').text.gsub("Doors at", "")
      doors_at = time

      doors_at = Chronic.parse(date.to_s + ", " + time.to_s)

      show = Show.new
      show.source = shows_url.to_s
      show.time_is_unknown = false

      show.doors_at = doors_at
      show.starts_at = doors_at.localtime
      show.venue_id = haileys.id
      puts show.to_yaml
      show.save

      position = 0
      bands.each do | band |
        band_name = Nokogiri::HTML( band.to_s ).text
        cleansed_band_name = band_name.downcase

        position += 1
        full_name = cleansed_band_name.split(' ').collect{ | x | x.capitalize}
        full_name = full_name.join( " " )
        puts full_name
        artist = Artist.find_or_create_by_name full_name
        artist.save
        puts artist

        gig = Gig.new
        gig.artist_id = artist.id
        gig.show_id = show.id
        gig.position = position
        gig.save
        show.gigs << gig
      end
      show.save
      puts show
    end


  end
end
