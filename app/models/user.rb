class User
  include Mongoid::Document
  rolify

  field :name, type: String
  field :provider, type: String
  field :uid, type: String

  validates_presence_of :name, :provider, :uid

  after_create :assign_default_role

  def assign_default_role
    add_role(:rater) if self.roles.blank?
  end

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.name = auth["info"]["name"]
    end
  end
end
