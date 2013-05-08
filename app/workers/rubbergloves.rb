#!/usr/bin/env ruby -wKU
require 'rubygems'
require 'open-uri'
require 'nokogiri'
require 'chronic'

# worker to scrape data from the following venue
class Rgrs
  @queue = :rgrs

  def self.perform
    rgrs = Venue.find_or_create_by_name "Rubber Gloves"
    rgrs.phone = "(940) 387-7781"
    rgrs.address = "411 East Sycamore, Denton, TX 76205"
    rgrs.save
    puts rgrs.name

    html = Nokogiri::HTML( open( 'http://rubberglovesdentontx.com/calendar/' ) )

    shows = Show.delete_all :venue_id => rgrs.id
    html.css("#calendar article.show").each do |gig|
      date = gig.css("header").text.split("-")[0].split(",").collect{|x|x.strip}.slice(1,2).join(", ")
      time = gig.css("ul.details li")[1].text.split(" ")[0]
      price = ''
      source = ''
      admittance = ''

      doors_at = gig.css("ul.details li")[1].text.split(' ')[0]

      full_date = Chronic.parse("#{date}, #{time}")
      show = Show.new
      show.starts_at = full_date
      show.doors_at = full_date
      show.source = "http://rubberglovesdentontx.com/calendar/"
      show.time_is_unknown = false
      show.venue_id = rgrs.id
      show.save

      position = 1
      gig.css("div.show-text header").text.split(",").collect{|x|x.gsub(/\s+/, ' ')}.each do |band_name|
        cleansed_band_name = band_name.gsub(/(.*)(p|P)resents(:?)/, '').downcase
        full_name = cleansed_band_name.split(' ').collect{ | x | x.capitalize}
        full_name = full_name.join( " " )
        band_key = band_name.strip.downcase.gsub(/\s/,'-').gsub(/[!]/, '').gsub('.','')
        puts full_name
        artist = Artist.find_or_create_by_name full_name
        artist.save

        gig = Gig.new
        gig.artist_id = artist.id
        gig.show_id = show.id
        gig.position = position
        gig.save

        show.gigs << gig

        position += 1
      end
    end
  end
end