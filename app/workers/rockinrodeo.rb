# rockinrodeo.rb
# http://www.rockinrodeodenton.com/events/

#!/usr/bin/env ruby -wKU
require 'rubygems'
require 'open-uri'
require 'nokogiri'
require 'chronic'



class Rockinrodeo
    @queue = :rgrs

    url = 'http://www.rockinrodeodenton.com/events/'

    def self.perform
        rockinrodeo = Venue.find_or_create_by_name "Rockinrodeo"
        rockinrodeo.phone = "xxx-xxx-xxxx"
        rockinrodeo.address = "1009 Avenue C"
        rockinrodeo.save
        puts rockinrodeo.name

        html = Nokogiri::HTML( open( 'http://www.rockinrodeodenton.com/events/' ) )

        shows = Show.delete_all :venue_id => rockinrodeo.id

        html.css("table.eventtable tbody tr").each do |gig|
            date = Chronic.parse( gig.css("td")[0].text.strip )
            puts date


            source = 'http://www.rockinrodeodenton.com/events/'

            show = Show.find_or_create_by_starts_at_and_venue_id_and_doors_at date, rockinrodeo.id
            show.time_is_unknown = true
            show.save
            puts show


            bands = gig.css("td")[1].text.split("w/").collect{|name| name.strip}
            puts bands

            bands.each_with_index do |band, index|
            	artist = Artist.find_or_create_by_name band
            	artist.save

                gig = Gig.new
                gig.artist_id = artist.id
                gig.show_id = show.id
                gig.position = index
                gig.save

                show.gigs << gig
            end
            # time = gig.css("ul.details li")[1].text.split(" ")[0]
            # price = ''
            # source = ''
            # admittance = ''

            # doors_at = gig.css("ul.details li")[1].text.split(' ')[0]

            # full_date = Chronic.parse("#{date}, #{time}").to_i
            # puts full_date
            # show = Show.find_or_create_by_starts_at_and_venue_id_and_doors_at full_date, rgrs.id

            # show.save
            # puts show.id

            # position = 1
            # gig.css("div.show-text header").text.split(",").collect{|x|x.gsub(/\s+/, ' ')}.each do |band_name|
            #     cleansed_band_name = band_name.gsub(/(.*)(p|P)resents(:?)/, '').downcase
            #     full_name = cleansed_band_name.split(' ').collect{ | x | x.capitalize}
            #     full_name = full_name.join( " " )
            #     puts full_name
            #     band_key = band_name.strip.downcase.gsub(/\s/,'-').gsub(/[!]/, '').gsub('.','')

            #     artist = Artist.find_or_create_by_name full_name
            #     artist.save
            #     puts artist.name
            #     puts artist.id

            #     gig = Gig.new
            #     gig.artist_id = artist.id
            #     gig.show_id = show.id
            #     gig.position = position
            #     gig.save
            #     puts gig.id

            #     show.gigs << gig

            #     position += 1
            # end
        end
    end
end