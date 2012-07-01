require 'spec_helper'

describe "Uploadable" do
  describe "uploadable" do
    it "all active record models should have access to uploadable methods" do
      Album.methods.should include(:uploadable)
      User.methods.should include(:uploadable)
      Track.methods.should include(:uploadable)
    end

    it "should initialize a procesor if model is uploadable" do
      Album.instance_variable_get(:@upload_processor).should_not be_nil
      User.instance_variable_get(:@upload_processor).should be_nil

      Album.instance_variable_get(:@upload_processor).model.should == Album
    end

    it "should defind upload_from_csv method for models" do
      Album.should respond_to(:upload_from_csv)
      Track.should respond_to(:upload_from_csv)
    end
  end

  describe "upload_from_csv" do
    it "should raise NoMethodError for non uploadable models" do
      lambda { User.upload_from_csv("") }.should raise_error(NoMethodError)
    end

    it "should upload to an uploadable model" do
      lambda { Album.upload_from_csv("Artist,Title,Extra\n\"John Denver\",\"All Aboard!\",1\n\"Usher\",\"Looking 4 Myself\",2")}.
        should change(Album, :count).by(2)
      Album.where(:artist => "John Denver", :title => "All Aboard!").count.should == 1
      Album.where(:artist => "Usher", :title => "Looking 4 Myself").count.should == 1
    end
  end
end
