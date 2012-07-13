#!/usr/bin/env ruby

require File.expand_path('../workers/dans.rb',  __FILE__)

require 'clockwork'
include Clockwork 
require 'resque'

every( 3.minutes, 'update.venues') { 
	puts 'update venues'
	Resque.enqueue(Dans)
}