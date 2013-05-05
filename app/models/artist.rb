# # FIXME
# class Artist < ActiveRecord::Base
#   has_many :gigs
#   has_many :shows, :through => :gigs

#   default_scope order("name")
#   # scope :alpha, lambda { group_by{ |u| u.name[0] } }

# end

# FIXME
class Artist
  include MongoMapper::Document
  plugin MongoMapper::Plugins::IdentityMap

  key :name, String

  many :gigs
  # has_many :shows, :through => :gigs

  # default_scope order("name")
  # scope :alpha, lambda { group_by{ |u| u.name[0] } }

end
