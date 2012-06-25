class Track < ActiveRecord::Base
  include Uploadable
  attr_accessible :album_id, :name

  belongs_to :album
end
