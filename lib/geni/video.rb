module Geni
  class Video < Base
    has_fetchable_attributes %w[
      title url date date_parts sizes
    ]
    
    def tags
      @tags ||= client.access_token.get("/api/#{id}/tags")['results'].collect do |profile|
        client.get_profile(profile['id'].split('-').last)
      end
    end
    
    def tag
      # FIXME
    end
    
    def untag
      # FIXME
    end
  end
end