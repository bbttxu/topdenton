class Food
  include Mongoid::Document
  include Mongoid::Taggable

  field :name, type: String
  field :address, type: String
  field :city, type: String
  field :state, type: String
  field :zipcode, type: String
  field :phone, type: String
  field :latitude, type: Float
  field :longitude, type: Float

  validates_presence_of :name, :address, :city, :state, :zipcode, :phone
end
