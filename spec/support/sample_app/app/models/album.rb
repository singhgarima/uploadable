class Album < ActiveRecord::Base
  uploadable :mandatory_fields => [:title], :optional_fields => [:artist]
  attr_accessible :artist, :title

  has_many :tracks
end
