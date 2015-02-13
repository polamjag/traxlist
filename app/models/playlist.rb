class Playlist
  include Mongoid::Document
  include Mongoid::Timestamps
  field :name, type: String
  field :tag, type: Array
  field :tracks, type: Array

  belongs_to :user
  validates_presence_of :name
end
