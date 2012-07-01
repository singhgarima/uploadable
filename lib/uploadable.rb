require "rails"

SOURCE_PATH = File.dirname(__FILE__)

require SOURCE_PATH + "/uploadable/railtie"
require SOURCE_PATH + "/uploadable/processor"
require SOURCE_PATH + "/uploadable/version"

module Uploadable
  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    def uploadable options = {}
      @upload_processor = Uploadable::Processor.new :model => self, :mandatory_fields => options[:mandatory_fields], :optional_fields => options[:optional_fields]
    end

    define_method :upload_from_csv do |contents|
      raise NoMethodError.new("Method only available for uploadable models") if @upload_processor.blank?
      records = @upload_processor.transform_csv contents
      create records
    end

  end
end
