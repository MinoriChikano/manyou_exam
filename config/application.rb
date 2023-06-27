require_relative "boot"

require "rails/all"

Bundler.require(*Rails.groups)

module EveryleafExam
  class Application < Rails::Application
    config.load_defaults 6.1
    config.time_zone = 'Tokyo'
    
  end
end


