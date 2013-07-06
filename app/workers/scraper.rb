# worst. name. ever.
require "rubygems"
require "resque"
require 'resque-loner'

class Scraper
  include Resque::Plugins::UniqueJob
end