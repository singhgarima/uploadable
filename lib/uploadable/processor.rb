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
      ::CSV.parse(csv_contents, {:headers => true, :header_converters => :symbol}) do |row|
        record = row.to_hash.reject { |keys,v| extra_headers.include?keys }
        record.each do |attr_name, value|
          record[attr_name] = self.model.send("tranform_#{attr_name}_for_upload", value) if self.model.respond_to?("tranform_#{attr_name}_for_upload")
        end
        records << record
      end
      records
    end

    private
    def validate_headers headers
      absent_fields = (self.mandatory - headers)
      raise Exception.new("Mandatory header(s): #{absent_fields.join(",")} is missing") unless absent_fields.blank?
    end

  end
end
