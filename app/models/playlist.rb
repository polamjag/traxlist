class Playlist
  include Mongoid::Document
  include Mongoid::Timestamps
  field :name, type: String
  field :tracks, type: Array
  field :description, type: String

  belongs_to :user
  validates_presence_of :name, :tracks
end
