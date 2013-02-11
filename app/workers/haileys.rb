#!/usr/bin/env ruby -wKU
require 'rubygems'
require 'open-uri'
require 'nokogiri'
require 'chronic'



class Haileys
  @queue = :haileys

  def self.perform()
    puts "updating Hailey's"

    haileys = Venue.find_or_create_by_name "Hailey's Club"
    haileys.phone = ""
    haileys.address = ""
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

      # infos = time.split "|"
      # debug infos
      date = show.at_css('span.date-display-single')
      date = date ? date.text.split('-')[1] : '12.12'
      date.gsub!('.','/')
      parts = date.split('/')
      month = parts[0]
      month = Date::MONTHNAMES[month.to_i]
      date_of_month = parts[1]
      date = month + " " + date_of_month
      time = show.css('ul.event-info li:first').text
      doors_at = time

      doors_at = Chronic.parse(date.to_s + ", " + time.to_s).to_i

      source = shows_url.to_s

      show = Show.find_or_create_by_starts_at_and_venue_id_and_doors_at doors_at, haileys.id
      show.save
      puts show

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
        puts gig.id
        # puts "New Gig #{gig.id} with #{gig.artist.name} @ #{gig.venue.name}"

        show.gigs << gig
      end
    end


  end
end
