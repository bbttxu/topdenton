#!/usr/bin/env ruby -wKU
require 'rubygems'
require 'open-uri'
require 'nokogiri'
require 'chronic'



class Rgrs
    @queue = :rgrs

    def self.perform
        rgrs = Venue.find_or_create_by_name "Rubber Gloves"
        rgrs.phone = ""
        rgrs.address = ""
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

            puts Chronic.parse(date).to_i
            show = Show.find_or_create_by_starts_at_and_venue_id_and_doors_at Chronic.parse(date).to_i, rgrs.id

            show.save
            puts show.id

            position = 1
            gig.css("div.show-text header").text.split(",").collect{|x|x.gsub(/\s+/, ' ')}.each do |band_name|
                cleansed_band_name = band_name.gsub(/(.*)(p|P)resents(:?)/, '').downcase
                full_name = cleansed_band_name.split(' ').collect{ | x | x.capitalize}
                full_name = full_name.join( " " )
                puts full_name
                band_key = band_name.strip.downcase.gsub(/\s/,'-').gsub(/[!]/, '').gsub('.','')

                artist = Artist.find_or_create_by_name full_name
                artist.save
                puts artist.name
                puts artist.id

                gig = Gig.new
                gig.artist_id = artist.id
                gig.show_id = show.id
                gig.position = position
                gig.save
                puts gig.id

                show.gigs << gig

                position += 1
            end
        end
    end
end