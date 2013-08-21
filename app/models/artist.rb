# An artist or band
class Artist
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, :type => String

  has_many :gigs, dependent: :delete
  # many :shows, :through => :gigs

  def as_json(options = nil)
    super((options || {}).merge(include: { gigs: { only: ["show_id"] } } ))
  end

  # accepts_nested_attributes_for :gigs

  scope :alphabetical, order_by(:name => :desc)
  # scope :recent, order_by(:created_at => :desc).limit(100)
end
