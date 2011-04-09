module Geni
  class Photo < Base
    
    has_fetchable_attributes %w[
      title url date date_parts content_type sizes album_id
    ]
    
    include Taggable
  end
end