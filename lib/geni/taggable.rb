module Geni
  module Taggable
    def tags
      return @tags if @tags
      
      response_hash = client.access_token.get("/api/#{id}/tags")
      
      if response_hash.has_key?('results')
        profile_ids = response_hash['results'].collect do |profile|
          profile['id']
        end

        @tags = client.get_profiles(profile_ids)
      else
        @tags = []
      end
    end
    
    def tag
      raise NotImplementedError
    end
    
    def untag
      raise NotImplementedError
    end
  end
end