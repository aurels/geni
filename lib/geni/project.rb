module Geni
  class Project < Base
    attr_reader :id, :name, :description, :url
    
    def collaborators
      @collaborators ||= client.access_token.get("/api/#{id}/collaborators")['results'].collect do |profile|
        Geni::Profile.new({
          :client => client,
          :attrs  => client.access_token.get("/api/#{profile['id']}")
        })
      end
    end
    
    def profiles
      @profiles ||= client.access_token.get("/api/#{id}/profiles")['results'].collect do |profile|
        Geni::Profile.new({
          :client => client,
          :attrs  => profile
        })
      end
    end
    
    def followers
      @followers ||= client.access_token.get("/api/#{id}/followers")['results'].collect do |profile|
        Geni::Profile.new({
          :client => client,
          :attrs  => client.access_token.get("/api/#{profile['id']}")
        })
      end
    end
  end
end