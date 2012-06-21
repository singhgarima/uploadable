require "rails"

SOURCE_PATH = File.dirname(__FILE__)

require SOURCE_PATH + "/uploadable/inspector"
require SOURCE_PATH + "/uploadable/output"
require SOURCE_PATH + "/uploadable/railtie"
require SOURCE_PATH + "/uploadable/version"

module Uploadable
  module ClassMethods
    def uploadable options = {}

    end
  end
end
