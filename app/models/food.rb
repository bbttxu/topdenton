class Food
  include Mongoid::Document
  include Mongoid::Taggable
  include Geocoder::Model::Mongoid

  resourcify

  has_one :rating

  field :name, type: String
  field :address, type: String
  field :city, type: String
  field :state, type: String
  field :zipcode, type: String
  field :phone, type: String
  field :coordinates, :type => Array

  index({coordinates: "2dsphere"})

  validates_uniqueness_of :name
  validates_presence_of :name, :address, :city, :state, :phone

  after_create :ensure_rating_for_food
  after_update :ensure_rating_for_food
  before_save :downcase_tags
  before_destroy :remove_rating_for_food

  geocoded_by :full_address, :skip_index => true
  after_validation :geocode


  protected
  def ensure_rating_for_food
    self.tags_array.each do |tag|
      Rating.find_or_create_by(food_id: self.id, tags_array: [tag]).save
    end
  end

  def downcase_tags
    self.tags = self.tags.downcase
  end

  def remove_rating_for_food
    Rating.where( food_id: self.id ).delete_all
  end

  def full_address
    [ self.address, self.city, self.state, self.zipcode ].join(", ")
  end
end
