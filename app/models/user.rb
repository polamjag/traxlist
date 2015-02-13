class User
  include Mongoid::Document
  field :provider, type: String
  field :uid, type: String
  field :name, type: String

  field :icon, type: String

  field :profile, type: String

  has_many :playlists
  validates_presence_of :name, :uid, :provider

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.name = auth["info"]["name"]
      user.icon = auth["info"]["image"]
      user.profile = auth["info"]["description"]
    end
  end
end
