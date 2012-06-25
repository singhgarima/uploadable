module Uploadable
  class Processor
    attr_accessor :mandatory, :optional
    def initialize options = {}
      self.mandatory = options[:mandatory_fields]
      self.optional = options[:optional_fields]
    end

  end
end
