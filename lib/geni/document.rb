module Geni
  class Document < Base
    attr_reader :id, :title, :url, :date, :date_parts, :content_type, :sizes, :description, :sizes
  
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