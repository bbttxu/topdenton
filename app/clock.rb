#!/usr/bin/env ruby

$stdout.sync = true

require File.expand_path('../workers/scraper.rb',  __FILE__)
require File.expand_path('../workers/dans.rb',  __FILE__)
require File.expand_path('../workers/haileys.rb',  __FILE__)
require File.expand_path('../workers/rubbergloves.rb',  __FILE__)
require File.expand_path('../workers/andys.rb',  __FILE__)
require File.expand_path('../workers/rockinrodeo.rb',  __FILE__)
require File.expand_path('../workers/abbey.rb',  __FILE__)
# require File.expand_path('../workers/untcalendar.rb',  __FILE__)

require 'clockwork'
include Clockwork
require 'resque'

every( 15.minutes, 'update.venues') {
  puts 'update venues'
  Resque.enqueue(Dans)
  Resque.enqueue(Haileys)
  Resque.enqueue(Rgrs)
  Resque.enqueue(Andys)
  # Resque.enqueue(Rockinrodeo)
  Resque.enqueue(Abbey)
  # Resque.enqueue(UNTCalendar)
}