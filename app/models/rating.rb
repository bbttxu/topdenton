class Rating
  include Mongoid::Document
  include Mongoid::Taggable

  rateable range: (1..10), raters: User, default_rater: 'owner'

  belongs_to :food

  before_save :downcase_tags

  def downcase_tags
    self.tags = self.tags.downcase
  end
end
