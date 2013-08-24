#!/usr/bin/env ruby -wKU
require 'rubygems'
require 'open-uri'
require 'nokogiri'
require 'chronic'

# worker to scrape data from the following venue
class Abbey < Scraper
  @queue = :abbey
  def self.perform()
    puts "updating Abbey Underground"

    abbey = Venue.find_or_create_by name: "Abbey Underground"
    abbey.phone = "(940) 566-5483"
    abbey.address = "101 W Hickory St  Denton, TX 76201"
    abbey.save
    shows = Show.destroy_all :venue_id => abbey.id

    html = Nokogiri::HTML( open("http://www.reverbnation.com/venue/1003284"))

    html.css('#shows_container li').each do | show_html |
      starts_at =  show_html.css('.details_time').text
      asdf = starts_at.gsub(",","").gsub(/\s/, " ").split(" ")
      event = "#{asdf[1]} #{asdf[2]} #{asdf[5]}"

      Chronic.time_class = Time.zone
      starts_at = Chronic.parse(event)

      source = []
      show_html.css('meta').each do |meta|
        source << meta['content'] if meta['itemprop'] == 'url'
      end

      # puts source[0]

      show = Show.find_or_create_by source: source[0]
      show.venue_id = abbey.id
      show.starts_at = starts_at
      show.time_is_unknown = false
      show.venue_id = abbey.id
      show.save


      band_name = show_html.css('h4.show_artist').text.strip
      cleansed_band_name = band_name.downcase
      full_name = cleansed_band_name.split(' ').collect{ | x | x.capitalize}
      full_name = full_name.join( " " )

      artist = Artist.find_or_create_by name: full_name
      artist.save

      i = 1

      gig = Gig.find_or_create_by show_id: show.id, artist_id: artist.id
      gig.position = i
      gig.save

      show.gigs << gig

      show_html.css('.details_other_bands .other_band').each do | other_band |
        # puts other_band.text

        new_band_name = other_band.text.split(' ').collect{ | x | x.capitalize}.join(" ")

        artist = Artist.find_or_create_by name: new_band_name
        artist.save
        i += 1

        gig = Gig.find_or_create_by show_id: show.id, artist_id: artist.id
        gig.position = i
        gig.save
      end
    end
  end
end
