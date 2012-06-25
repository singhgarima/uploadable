require 'spec_helper'

describe "Uploadable::Processor" do
  it "should take manadatory and optional attributes while initializing" do
    processor = Uploadable::Processor.new :mandatory_fields => [:required], :optional_fields => [:maybe]
    processor.mandatory.should == [:required]
    processor.optional.should == [:maybe]
  end
end
