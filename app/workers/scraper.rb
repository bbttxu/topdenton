# worst. name. ever.
require "rubygems"
require "resque"
require 'resque-loner'
require 'cachebar'

class Scraper
  include Resque::Plugins::UniqueJob
end