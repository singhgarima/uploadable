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
  end

  describe "upload_from_file" do
    it "should upload to a model from the provided file" do

    end
  end
end
