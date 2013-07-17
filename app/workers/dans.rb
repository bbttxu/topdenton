#!/usr/bin/env ruby -wKU
require 'rubygems'
require 'open-uri'
require 'nokogiri'
require 'chronic'
require 'yaml'

# worker to scrape data from the following venue
class Dans < Scraper
  @queue = :dans

  def self.perform()

    puts "updating Dans"

    dans = Venue.find_or_create_by name: "Dan's Silverleaf"
    dans.phone = "9403202000"
    dans.address = "103 Industrial Street, Denton, TX 76201-4223"
    dans.save

    shows = Show.delete_all :venue_id => dans.id

    html = Nokogiri::HTML( open( 'http://danssilverleaf.com/' ) )
    html.css("div.show").each do |div|
      show = Show.new
      date = div.at_css('h6').text.split(', ')[1]
      time = div.css('div.details p:first').text.gsub(/\s+/, "")
      time_array = time.split("|")
      show_info = {}
      time_array.each do |x|
        x.strip!
        y = x.split ":", 2
        if y.length >= 2
          show_info[ y[0].strip ] = y[1].strip
        end
      end

      show.price = show_info['Price'] || nil
      show.source = 'http://danssilverleaf.com/#' + div.attr("id")
      show.time_is_unknown = false

      show.doors_at = Chronic.parse("#{date.to_s} #{show_info['Show']}".gsub(/\s+/, ' ') )
      show.starts_at = Chronic.parse("#{date.to_s} #{show_info['Show']}".gsub(/\s+/, ' ') ).localtime
      show.venue_id = dans.id
      show.save


      bands = div.at_css('h2').text
      position = 1
      bands.split('/').each_with_index do |band_name, i|
        band_name = band_name.downcase.split(/\s/).collect{ | x | x.capitalize}.join(" ").strip
        artist = Artist.find_or_create_by name: band_name
        artist.save if artist.new_record?


        gig = Gig.new
        gig.show_id = show.id
        gig.artist_id = artist.id
        gig.position = position
        gig.save

        position += 1
      end
      show.save
    end

  end
end