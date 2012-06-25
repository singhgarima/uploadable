require 'spec_helper'

describe "Uploadable" do
  it "all active record models should have access to uploadable methods" do
    Album.methods.should include(:uploadable)
    User.methods.should include(:uploadable)
    Track.methods.should include(:uploadable)
  end

end
