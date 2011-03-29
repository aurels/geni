$LOAD_PATH.unshift File.dirname(File.expand_path(__FILE__)) + '/lib'

require 'rubygems'
require 'oauth2'
require 'geni'

module MockedResponsesHelper
  def get_mocked_response(url)
    identifier = url.gsub(/(\/|\?)/, '_')
    path = "spec/support/mocked_responses/#{identifier}.txt"
    if File.exists?(path)
      File.read(path)
    else
      response = `curl #{url}`
      File.open(path, 'w') do |f|
        f.write response
      end 
      response
    end
  end
end

module GeniSpecHelper
  def get_geni_client
    Geni::Client.new({
      :app_id     => 'FAKE_APP_ID',
      :app_secret => 'FAKE_APP_SECRET',
      :token      => 'FAKE_OAUTH_TOKEN'
    })
  end
  
  def get_geni_token
    ENV['GENI_OAUTH_TOKEN']
  end
end

RSpec.configure do |config|
  config.mock_with :rspec
  config.include MockedResponsesHelper
  config.include GeniSpecHelper
end

Faraday.default_adapter = :test
