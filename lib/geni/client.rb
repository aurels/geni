module Geni
  class Client

    SITE              = 'https://www.geni.com'
    ACCESS_TOKEN_PATH = '/oauth/token'

    attr_reader :oauth_client, :access_token, :callback

    def initialize(params = {})

      @callback = params[:callback] ? params[:callback] : '/callback'

      @oauth_client = OAuth2::Client.new(params[:app_id], params[:app_secret],
        :site              => SITE,
        :parse_json        => true,
        :access_token_path => ACCESS_TOKEN_PATH
      )
      
      @access_token = OAuth2::AccessToken.new(oauth_client, params[:token])
    end
            
    TYPES = {
      'profile'  => Geni::Profile,
      'union'    => Geni::Union,
      'project'  => Geni::Project,
      'photo'    => Geni::Photo,
      'document' => Geni::Document,
      'video'    => Geni::Video
    }
    
    TYPES.each_pair do |type, klass|
      define_method "get_#{type}" do |id|
        entity = klass.new({
          :client => self,
          :id     => id
        })
      end
    end
    
    def get_profiles(ids)
      return [] if ids.empty?
      return [get_profile(ids.first)] if ids.one?
      
      numbers = ids.collect { |id| id.gsub(/profile-/, '') }.join(',')
      url = "/api/profile-#{numbers}"
      results = access_token.get(url)['results']
      
      results.collect do |profile_attrs|
        Geni::Profile.new({
          :client  => self,
          :attrs   => profile_attrs,
          :fetched => true
        })
      end
    end
    
    def me
      Geni::Profile.new({
        :client  => self,
        :attrs   => access_token.get('/api/profile'),
        :fetched => true
      })
    end
    
    def [](entity_id)
      entity_type = entity_id.split('-').first
      send("get_#{entity_type}", entity_id)
    end
        
    def redirect_uri(request)
      uri = URI.parse(request.url)
      uri.path = @callback
      uri.query = nil
      uri.to_s
    end
    
    def authorize_url(request)
      oauth_client.web_server.authorize_url({
        :redirect_uri => redirect_uri(request)
      })
    end
    
    def get_token(code, request)
      oauth_client.web_server.get_access_token(code, {
        :redirect_uri => redirect_uri(request)
      }).token
    end
  end
end