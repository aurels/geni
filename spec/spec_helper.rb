$LOAD_PATH.unshift File.dirname(File.expand_path(__FILE__)) + '/lib'

require 'rubygems'
require 'digest/md5'
require 'oauth2'
require 'geni'

module MockedResponsesHelper
  def get_mocked_response(url)
    identifier = Digest::MD5.hexdigest(url.gsub(/(\/|\?)/, '_'))
    path = "spec/support/mocked_responses/#{identifier}.json"
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
    client = Geni::Client.new({
      :app_id     => 'FAKE_APP_ID',
      :app_secret => 'FAKE_APP_SECRET',
      :token      => 'FAKE_OAUTH_TOKEN'
    })
    
    mock_urls = [
      '/api/profile',
      '/api/profile-90990730',
      '/api/profile-90990739/immediate-family',
      '/api/profile-90990897,90990889',
      '/api/profile-90990832,90990843,90990667',
      '/api/profile-90990985,90990977,90990923,90990957',
      '/api/profile-90990667',
      '/api/profile-90990667,90990668',
      '/api/union-12276689',
      '/api/photo-21557506',
      '/api/project-6',
      '/api/document-339953',
      '/api/profile-109599192',
      '/api/document-339953/tags',
      '/api/profile-90990667/immediate-family',
      '/api/profile-90990667/photos',
      '/api/profile-90990667/videos',
      '/api/profile-90990667/documents',
      '/api/project-6/collaborators',
      '/api/project-6/profiles',
      '/api/project-6/followers',
      '/api/video-1/tags',
      '/api/profile-109599192',
      '/api/profile-34069147,55243122,22432,52956166,17217530,71684074,113176368,58021742',
      '/api/profile-37184377,104782442,30281154,26994163,25369660,21351140,103396622,56364915,4344802,7712690,21351129,20730383,11100005,4317082,3527751,4379529,29780568,4317326,17672882,30678724,21522719,28335975,3690728,4251352,20606274,6535565,92378177',
      '/api/profile-34069147,55243122,22432,91947976,13347712,50487702,61008451,52956166,17217530,9087412,48377152,51993956,4926060,110665774,56135638,31078957,2275290,112048725,41047148,17354640,104803606,15130251,71684074,93546487,113176368,110038906,83672444,56654534,57591505,112588615,108772336,109100428,618351,57643235,49330918,58021742,118861761,119180796,119083346,118469212,109378679,121922069',
      '/api/video-1'
    ]
    
    client.oauth_client.connection.build do |b|
      b.adapter :test do |stub|        
        mock_urls.each do |url|
          stub.get("#{url}?access_token=FAKE_OAUTH_TOKEN") do |env|
            [200, {}, get_mocked_response("https://www.geni.com#{url}?access_token=#{get_geni_token}")]
          end
        end
      end
    end
    
    return client
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
