module Geni
  class Client

    SITE              = 'https://www.geni.com'
    ACCESS_TOKEN_PATH = '/oauth/token'

    attr_reader :oauth_client, :access_token

    def initialize(params = {})
      @oauth_client = OAuth2::Client.new(params[:app_id], params[:app_secret],
        :site              => SITE,
        :parse_json        => true,
        :access_token_path => ACCESS_TOKEN_PATH
      )
      
      @access_token = OAuth2::AccessToken.new(oauth_client, params[:token])
    end
    
    def get_profile(id_or_ids = nil)
      if id_or_ids.nil?
        url = "/api/profile"
      elsif id_or_ids.kind_of?(Array)
        if id_or_ids.any?
          url = "/api/profile-#{id_or_ids.join(',')}"
        else
          return []
        end
      else
        url = "/api/profile-#{id_or_ids}"
      end
            
      results = access_token.get(url)
      results = results['results'] if results.has_key?('results')
      
      profiles = [results].flatten.collect do |profile_attrs|
        Geni::Profile.new({
          :client => self,
          :attrs  => profile_attrs
        })
      end
      
      id_or_ids.kind_of?(Array) ? profiles : profiles.first
    end
    
    class << self
      def redirect_uri(request)
        uri = URI.parse(request.url)
        uri.path = '/callback'
        uri.query = nil
        uri.to_s
      end
    end
  end
end