module Geni
  class Video < Base
    has_fetchable_attributes %w[
      title url date date_parts sizes
    ]
    
    def tags
      # FIXME
    end
    
    def tag
      # FIXME
    end
    
    def untag
      # FIXME
    end
  end
end