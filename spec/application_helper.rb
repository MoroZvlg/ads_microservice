require 'spec_helper'

ENV['RACK_ENV'] ||= 'test'

require_relative '../config/environment'

abort 'DANGER!!! You run spec in production environment' if Application.environment == :production

Dir[Application.root.concat('/spec/support/**/*.rb')].sort.each {|f| require f}

RSpec.configure do |config|
  config.include Rack::Test::Methods
  config.include RouteHelpers, type: :request

  config.before(:each) do
    I18n.locale = I18n.default_locale
  end
end