module Geni
  class Document < Base
    has_fetchable_attributes %w[
      title url date date_parts content_type description sizes
    ]
  
    def tags
      @tags ||= client.get_profile(client.access_token.get("/api/#{id}/tags")['results'].collect { |profile|
        profile['id'].split('-').last
      })
    end
    
    def tag
      # FIXME
    end
    
    def untag
      # FIXME
    end
  end
end