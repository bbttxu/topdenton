require 'rubygems'
require 'open-uri'
require 'nokogiri'
require 'chronic'

# worker to scrape data from the following venue
class Rockinrodeo < Scraper
  @queue = :rgrs

  url = 'http://www.rockinrodeodenton.com/events/'

  def self.perform
    rockinrodeo = Venue.find_or_create_by_name "Rockinrodeo"
    rockinrodeo.phone = "xxx-xxx-xxxx"
    rockinrodeo.address = "1009 Avenue C"
    rockinrodeo.save


    html = Nokogiri::HTML( open( 'http://www.rockinrodeodenton.com/events/' ) )

    shows = Show.delete_all :venue_id => rockinrodeo.id

    html.css("table.eventtable tbody tr").each do |gig|
      Chronic.time_class = Time.zone
      date = Chronic.parse( gig.css("td")[0].text.strip )



      source = 'http://www.rockinrodeodenton.com/events/'

      show = Show.find_or_create_by_starts_at_and_venue_id_and_doors_at date, rockinrodeo.id
      show.time_is_unknown = true
      show.save



      bands = gig.css("td")[1].text.split("w/").collect{|name| name.strip}


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
    end
  end
end
