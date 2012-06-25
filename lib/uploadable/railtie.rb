require 'uploadable'

module Uploadable
  class Railtie < Rails::Railtie
    initializer "uploadable.including_module" do
      ActiveRecord::Base.send(:include, Uploadable) 
    end

  end
end
