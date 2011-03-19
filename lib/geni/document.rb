module Geni
  class Document < Base
    attr_reader :id, :title, :url, :date, :date_parts, :content_type, :sizes, :description, :sizes
  
    def tags
      @tags ||= client.access_token.get("/api/#{id}/tags")['results'].collect do |profile|
        Geni::Profile.new({
          :client => client,
          :attrs  => client.access_token.get("/api/#{profile['id']}")
        })
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