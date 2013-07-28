class Rating
  include Mongoid::Document
  include Mongoid::Taggable

  rateable range: (1..10), raters: User, default_rater: 'owner'

  belongs_to :food
end
