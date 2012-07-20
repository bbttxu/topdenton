#!/usr/bin/env ruby

$stdout.sync = true

require File.expand_path('../workers/dans.rb',  __FILE__)
require File.expand_path('../workers/haileys.rb',  __FILE__)
require File.expand_path('../workers/rubbergloves.rb',  __FILE__)

require 'clockwork'
include Clockwork 
require 'resque'

every( 3.minutes, 'update.venues') { 
	puts 'update venues'
  Resque.enqueue(Dans)
  Resque.enqueue(Haileys)
  Resque.enqueue(Rgrs)
}