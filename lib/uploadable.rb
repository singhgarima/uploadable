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

    define_method :upload_from_csv! do |contents, options = {}|
      raise NoMethodError.new("Method only aviable for uploadable models") if @upload_processor.blank?
      objects = []
      failed = false
      ActiveRecord::Base.transaction do
        records = @upload_processor.transform_csv contents
        objects = create records
        failed = true and raise ActiveRecord::Rollback if objects.any? {|obj| !obj.errors.full_messages.blank?}
      end
      return objects.each_with_index.collect do |obj, index| 
        options[:error_message].gsub('%{csv_line_number}', (index+1).to_s).gsub(/%\{[^\}]*\}/){ |m| obj.instance_eval(m[2..(m.length-2)]) } if obj.errors.present?
      end.compact if failed and !options[:error_message].blank?
    end
  end
end
