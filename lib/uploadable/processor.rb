require 'csv'

module Uploadable
  class Processor
    attr_accessor :mandatory, :optional, :model
    def initialize options = {}
      self.model = options[:model]
      self.mandatory = options[:mandatory_fields]
      self.optional = options[:optional_fields]
    end

    def transform_csv csv_contents
      records = []
      headers = ::CSV.parse_line(csv_contents, {:headers => true, :header_converters => :symbol}).to_hash.keys
      validate_headers headers
      extra_headers = headers - self.mandatory - self.optional
      ::CSV.parse(csv_contents, {:headers => true, :header_converters => lambda { |d| humanized_attr_mapping(headers)[d] || d.gsub(/\s+/, "").underscore.to_sym }}) do |row|
        record = row.to_hash.reject { |key, v| extra_headers.include? key }
        row.to_hash.each { |k, v| record[k]=self.model.send("transform_#{k}_for_upload", v) if self.model.respond_to?("transform_#{k}_for_upload") }

        records << record
      end
      records
    end

    private
    def validate_headers headers
      absent_fields = (self.mandatory - headers)
      raise Exception.new("Mandatory header(s): #{absent_fields.join(",")} is missing") unless absent_fields.blank?
    end

    def humanized_attr_mapping(headers)
      self.model.attribute_names.inject({}) do |header_to_field, attr|
        header_to_field[self.model.human_attribute_name(attr)] = attr.gsub(/\s+/, "").underscore.to_sym
        header_to_field
      end
    end
  end
end
