#!/usr/bin/env ruby -wKU
require 'rubygems'
require 'open-uri'
require 'nokogiri'
require 'chronic'

class Dans  
  @queue = :dans
  def self.perform()
  	puts "updating Dans"

    dans = Venue.find_or_create_by_name "Dan's Silverleaf"
    dans.phone = "9403202000"
    dans.address = "103 Industrial Street, Denton, TX 76201-4223"
    dans.save
    
    html = Nokogiri::HTML( open( 'http://danssilverleaf.com/' ) )
 
    html.css("div.show").each do | show |
      bands = show.at_css('h2').text
      



      time = show.at_css('h2').text
         
     infos = time.split " | "
      # debug infos
      date = show.at_css('h6').text.split(', ')[1]
      time = show.css('div.details p:first').text.gsub(/\s+/, "")
      time_array = time.split("|")
      show_info = {}
      # puts time
      time_array.each do |x|
        x.strip!
        y = x.split ":", 2
        if y.length >= 2
          show_info[ y[0].strip ] = y[1].strip
        end
      end
      price = show_info['Price'] || ""
      show_time = show_info['Show'] || ""
      doors_at = show_info['Doors'] || ""
      admittance = show_info['Admittance'] || ""
      source = 'http://danssilverleaf.com/#' + show.attr("id")

      show = Show.find_or_create_by_starts_at_and_venue_id_and_doors_at Chronic.parse(date.to_s + " " + show_time.to_s).to_i, dans.id
      show.doors_at = Chronic.parse(date.to_s + " " + doors_at.to_s).to_i
      show.price = price
      show.source = source
      show.admittance = admittance
      show.save
      
      puts "show at #{dans.name}, #{show.starts_at}"
      bands.split('/').each_with_index do | band_name, i |
        # puts band_name
        cleansed_band_name = band_name.downcase
        full_name = cleansed_band_name.split(' ').collect{ | x | x.capitalize}
        full_name = full_name.join( " " )
        puts full_name
        artist = Artist.find_or_create_by_name full_name
        artist.save

        gig = Gig.new
        gig.artist_id = artist.id
        gig.show_id = show.id
        gig.position = i
        gig.save
        puts gig

        show.gigs << gig

      end
    show.save

    end
  end  
end  