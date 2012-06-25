require "rails"

SOURCE_PATH = File.dirname(__FILE__)

require SOURCE_PATH + "/uploadable/railtie"
require SOURCE_PATH + "/uploadable/version"

module Uploadable
  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    def uploadable options = {}
    end
  end
end
