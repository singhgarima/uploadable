require 'spec_helper'

describe "Uploadable::Processor" do
  it "should take mandatory and optional attributes while initializing" do
    processor = Uploadable::Processor.new :mandatory_fields => [:required], :optional_fields => [:maybe], :model => TestModel
    processor.mandatory.should == [:required]
    processor.optional.should == [:maybe]
    processor.model.should == TestModel
  end

  describe "transform_csv" do
    it "should error out if headers are not valid" do
      processor = Uploadable::Processor.new :mandatory_fields => [:title], :optional_fields => [:artist]
      lambda { processor.transform_csv "Artist\n\"John Denver\"" }.should raise_error("Mandatory header(s): title is missing")
    end

    it "should transform csv into array of hashes and reject extra columns" do
      processor = Uploadable::Processor.new :mandatory_fields => [:artist], :optional_fields => [:title], :model => Album
      result = processor.transform_csv "Artist,Title,Extra\n\"John Denver\",\"All Aboard!\",1\n\"Usher\",\"Looking 4 Myself\",2"

      result.should == [{:artist => "John Denver", :title => "All Aboard!"}, {:artist => "Usher", :title => "Looking 4 Myself"}]
    end

    it "should transform the column values for which transform method is present" do
      processor = Uploadable::Processor.new :mandatory_fields => [:name], :optional_fields => [:top_rated], :model => Track
      result = processor.transform_csv "Name,Top Rated\n\"Waiting For A Train\",Y\n\"People Get Ready\",N\n\"Lining Track\","

      result.should == [{:name => "Waiting For A Train", :top_rated => true}, {:name => "People Get Ready", :top_rated => false},
                        {:name => "Lining Track", :top_rated => false}]
    end

    it "should map the human attribute names" do
      processor = Uploadable::Processor.new :mandatory_fields => [:title], :optional_fields => [:artist], :model => Album
      result = processor.transform_csv "Artist Name,Title\n\"John Denver\",\"All Aboard!\"\n\"Usher\",\"Looking 4 Myself\""
    result.should == [{:artist => "John Denver", :title => "All Aboard!"},{:artist => "Usher", :title => "Looking 4 Myself"} ]
    end
  end
end

class TestModel
end
