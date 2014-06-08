class Rating
  include Mongoid::Document
  include Mongoid::Taggable

  rateable range: (1..10), raters: User, default_rater: 'owner'

  belongs_to :food

  before_save :downcase_tags

  scope :top_one, ->(limit=1) { order_by([:rating, :asc]).limit(limit) }

  scope :top_five, ->(limit=5) { order_by([:rating, :asc]).limit(limit) }

  def downcase_tags
    self.tags = self.tags.downcase
  end
end
