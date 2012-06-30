class Track < ActiveRecord::Base
  uploadable :mandatory_fields => [:name], :optional_fields => [:top_rated]
  attr_accessible :album_id, :name

  belongs_to :album

  def self.tranform_top_rated_for_upload value
    value == 'Y' ? true : false
  end
end
