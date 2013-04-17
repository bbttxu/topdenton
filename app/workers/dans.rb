#!/usr/bin/env ruby -wKU
require 'rubygems'
require 'open-uri'
require 'nokogiri'
require 'chronic'
require 'yaml'


class Dans
  @queue = :dans

  def self.perform()

    puts "updating Dans"

    dans = Venue.find_or_create_by_name "Dan's Silverleaf"
    dans.phone = "9403202000"
    dans.address = "103 Industrial Street, Denton, TX 76201-4223"
    dans.save

    # shows = Show.delete_all :venue_id => dans.id

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
      puts Chronic.parse("#{date.to_s} #{show_info['Show']}".gsub(/\s+/, ' ') )
      show.doors_at = Chronic.parse("#{date.to_s} #{show_info['Show']}".gsub(/\s+/, ' ') )
      show.starts_at = Chronic.parse("#{date.to_s} #{show_info['Show']}".gsub(/\s+/, ' ') )
      # show.starts_at = Chronic.parse(date.to_s + " " + show_info['Show'].to_s)

      puts show.to_yaml

      # show.show_time = Chronic.parse(date.to_s + " " + show_info['Show'].to_s) || nil
      # show.admittance = show_info['Admittance'] || nil

      # price = show_info['Price'] || ""
      # show_time = show_info['Show'] || ""
      # doors_at = show_info['Doors'] || ""
      # admittance = show_info['Admittance'] || ""

      # show = Show.find_or_create_by_starts_at_and_venue_id_and_doors_at Chronic.parse(date.to_s + " " + show_time.to_s).to_i, dans.id
      # show.price = price
      # show.admittance = admittance

      bands = div.at_css('h2').text
      bands.split('/').each_with_index do |band_name, i|
        band_name = band_name.downcase.split(/\s/).collect{ | x | x.capitalize}.join(" ").strip
        artist = Artist.find_or_create_by_name band_name
        artist.save
        # puts artist.name
      end
    end

    # html.css("div.show").each do | show |
    #   bands = show.at_css('h2').text
    #   puts bands
    #   time = show.at_css('h2').text
    #   # puts show

    #   infos = time.split " | "
    #   # debug infos
    #   date = show.at_css('h6').text.split(', ')[1]
    #   time = show.css('div.details p:first').text.gsub(/\s+/, "")
    #   time_array = time.split("|")
    #   show_info = {}
    #   time_array.each do |x|
    #     x.strip!
    #     y = x.split ":", 2
    #     if y.length >= 2
    #       show_info[ y[0].strip ] = y[1].strip
    #     end
    #   end
    #   price = show_info['Price'] || ""
    #   show_time = show_info['Show'] || ""
    #   doors_at = show_info['Doors'] || ""
    #   admittance = show_info['Admittance'] || ""
    #   source = 'http://danssilverleaf.com/#' + show.attr("id")

    #   show = Show.find_or_create_by_starts_at_and_venue_id_and_doors_at Chronic.parse(date.to_s + " " + show_time.to_s).to_i, dans.id
    #   show.doors_at = Chronic.parse(date.to_s + " " + doors_at.to_s).to_i
    #   show.price = price
    #   show.source = source
    #   show.admittance = admittance
    #   show.time_is_unknown = false


    #   # show.save

    #   # puts "show at #{dans.name}, #{show.starts_at}"
    #   bands.split('/').each_with_index do | band_name, i |
    #   # puts band_name
    #   cleansed_band_name = band_name.downcase
    #   full_name = cleansed_band_name.split(' ').collect{ | x | x.capitalize}
    #   full_name = full_name.join( " " )
    #   # puts full_name
    #   artist = Artist.find_or_create_by_name full_name
    #   artist.save

    #   gig = Gig.new
    #   gig.artist_id = artist.id
    #   gig.show_id = show.id
    #   gig.position = i
    #   # gig.save
    #   # puts gig

    #   show.gigs << gig

    # end
    # show.save

    # end
  end
end