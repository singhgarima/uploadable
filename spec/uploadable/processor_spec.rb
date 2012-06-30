require 'spec_helper'

describe "Uploadable::Processor" do
  it "should take manadatory and optional attributes while initializing" do
    processor = Uploadable::Processor.new :mandatory_fields => [:required], :optional_fields => [:maybe], :model => TestModel
    processor.mandatory.should == [:required]
    processor.optional.should == [:maybe]
    processor.model.should == TestModel
  end

  describe "transform_csv" do
    xit "should transform csv into array of hashs" do
      processor = Uploadable::Processor.new :mandatory_fields => [:required], :optional_fields => [:maybe]

      process.transform_csv 

    end
  end
end

class TestModel
end
