$LOAD_PATH.unshift File.dirname(File.expand_path(__FILE__)) + '/lib'

require 'rubygems'
require 'oauth2'
require 'geni'

RSpec.configure do |config|
  config.mock_with :rspec
end

Faraday.default_adapter = :test