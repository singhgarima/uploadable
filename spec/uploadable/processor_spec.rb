require 'spec_helper'

describe "Uploadable::Processor" do
  it "should take manadatory and optional attributes while initializing" do
    processor = Uploadable::Processor.new :mandatory_fields => [:required], :optional_fields => [:maybe], :model => TestModel,
      :external_fields => [:belongs_to_field]
    processor.mandatory.should == [:required]
    processor.optional.should == [:maybe]
    processor.external.should == [:belongs_to_field]
    processor.model.should == TestModel
  end

  describe "transform_csv" do
    it "should error or of headers not valid" do
      processor = Uploadable::Processor.new :mandatory_fields => [:title], :optional_fields => [:artist]
      lambda { processor.transform_csv "Artist\n\"John Denver\"" }.should raise_error("Mandatory header(s): title is missing")
    end

    it "should transform csv into array of hashes and reject extra columns" do
      processor = Uploadable::Processor.new :mandatory_fields => [:artist], :optional_fields => [:title]
      result = processor.transform_csv "Artist,Title,Extra\n\"John Denver\",\"All Aboard!\",1\n\"Usher\",\"Looking 4 Myself\",2"

      result.should == [{:artist => "John Denver", :title => "All Aboard!"}, {:artist=>"Usher", :title=>"Looking 4 Myself"}]
    end

    it "should transform the column values for which transform method is present" do
      processor = Uploadable::Processor.new :mandatory_fields => [:name], :optional_fields => [:top_rated], :model => Track
      result = processor.transform_csv "Name,Top Rated\n\"Waiting For A Train\",Y\n\"People Get Ready\",N\n\"Lining Track\","

      result.should == [{:name => "Waiting For A Train", :top_rated => true}, {:name => "People Get Ready", :top_rated => false},
                        {:name => "Lining Track", :top_rated => false}]
    end

    it "should transform external columns to references inside the given table" do
      albumA = Album.create :artist => 'Artist A', :title => "AlbumA"
      albumB = Album.create :artist => 'Artist B', :title => "AlbumB"

      processor = Uploadable::Processor.new :mandatory_fields => [:name], :optional_fields => [:top_rated], :external_fields => [:album], :model => Track
      result = processor.transform_csv "Name,Top Rated,Album\n\"Waiting For A Train\",Y,AlbumA\n\"People Get Ready\",N,AlbumA\n\"Lining Track\",,AlbumB"

      result.should == [{:name => "Waiting For A Train", :top_rated => true, :album_id => albumA.id}, {:name => "People Get Ready", :top_rated => false, :album_id => albumA.id},
                        {:name => "Lining Track", :top_rated => false, :album_id => albumB.id}]
    end
  end
end

class TestModel
end
