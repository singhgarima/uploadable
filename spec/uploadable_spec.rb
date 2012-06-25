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
    end

    it "should defind upload_from_csv method for models" do
      Album.should respond_to(:upload_from_csv)
      Track.should respond_to(:upload_from_csv)
    end
  end

  describe "upload_from_csv" do

    it "should raise NoMethodError for non uploadable models" do
      lambda { User.upload_from_csv }.should raise_error(NoMethodError)
    end
  end
end
