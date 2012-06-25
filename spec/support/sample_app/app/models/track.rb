class Track < ActiveRecord::Base
  uploadable
  attr_accessible :album_id, :name

  belongs_to :album
end
