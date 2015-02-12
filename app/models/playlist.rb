class Playlist
  include Mongoid::Document
  field :name, type: String
  field :tag, type: Array
  field :tracks, type: Array

  embedded_in :user
end
