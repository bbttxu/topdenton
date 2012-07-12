# require 'config/boot'
# require 'config/environment'

require 'clockwork'
include Clockwork 

every( 3.minutes, 'marketpoint.fetch') { 
	puts 'update venues'
	# Delayed::Job.enqueue MarketPointJob.new 
}