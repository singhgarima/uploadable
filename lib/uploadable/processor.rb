module Uploadable
  class Processor
    attr_accessor :mandatory, :optional, :model
    def initialize options = {}
      self.model = options[:model]
      self.mandatory = options[:mandatory_fields]
      self.optional = options[:optional_fields]
    end

  end
end
