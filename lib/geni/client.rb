module Geni
  class Client
    
    # Constants
    
    SITE = 'https://www.geni.com'
    
    # Attributes
    
    attr_reader :app_id, :app_secret, :access_token
    
    # Methods
    
    def initialize(params = {})
      @app_id       = params[:app_id]
      @app_secret   = params[:app_secret]
      @access_token = params[:access_token]
    end
    
    def profile(id = nil)
      profile_id = id.nil? ? '' : "-#{id}"
      Geni::Profile.new({
        :access_token => @access_token,
        :attrs        => @access_token.get("/api/profile#{profile_id}")
      })
    end
  end
end