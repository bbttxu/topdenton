#!/usr/bin/env ruby -wKU
require 'rubygems'
require 'open-uri'
require 'nokogiri'
require 'chronic'

class Andys  
  @queue = :andys
  def self.perform()
  	puts "updating andys"

    andys = Venue.find_or_create_by_name "Andys"
    andys.phone = ""
    andys.address = ""
    andys.save
    shows = Show.delete_all :venue_id => andys.id
    
    html = Nokogiri::HTML( open("http://www.reverbnation.com/venue/andysbar"))
    
    # puts html
    
    html.css('#shows_container li').each do | show_html |
      starts_at =  show_html.css('.details_time').text
      # puts starts_at.split
      asdf = starts_at.gsub(",","").gsub(/\s/, " ").split(" ")
      event = "#{asdf[1]} #{asdf[2]} #{asdf[5]}"
      # puts event
      starts_at = Chronic.parse(event).to_i
      # puts starts_at

      source = []
      show_html.css('meta').each do |meta|
        source << meta['content'] if meta['itemprop'] == 'url'
      end

      puts source[0]

      show = Show.find_or_create_by_source source[0]
      show.venue_id = andys.id
      show.starts_at = starts_at
      show.save
      puts show.id


      band_name = show_html.css('h4.show_artist').text.strip
      cleansed_band_name = band_name.downcase
      full_name = cleansed_band_name.split(' ').collect{ | x | x.capitalize}
      full_name = full_name.join( " " )
      
      artist = Artist.find_or_create_by_name full_name
      artist.save
      puts artist.id
      
      i = 1

      gig = Gig.find_or_create_by_show_id_and_artist_id( show.id, artist.id )
      gig.position = i
      gig.save
      puts gig.id

      show.gigs << gig

      show_html.css('.details_other_bands .other_band').each do | other_band |
        puts other_band.text
        
        new_band_name = other_band.text.split(' ').collect{ | x | x.capitalize}.join(" ")
        
        artist = Artist.find_or_create_by_name new_band_name
        artist.save
        puts artist.id
        i += 1
        
        gig = Gig.find_or_create_by_show_id_and_artist_id( show.id, artist.id )
        gig.position = i
        gig.save
        puts gig.id

      end
    end
  end  
end