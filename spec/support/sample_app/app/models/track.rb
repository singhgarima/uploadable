class Track < ActiveRecord::Base
  uploadable :mandatory_fields => [:name], :optional_fields => [:top_rated], :external_fields => [:album]
  attr_accessible :album_id, :name

  belongs_to :album

  def self.tranform_top_rated_for_upload value
    value == 'Y' ? true : false
  end

  def self.convert_album_for_upload value
    { :album_id => Album.where( :title => value).first.id }
  end
end
