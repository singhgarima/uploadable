class Album < ActiveRecord::Base
  uploadable
  attr_accessible :artist, :title

  has_many :tracks
end
