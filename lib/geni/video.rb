module Geni
  class Video < Base
    has_fetchable_attributes %w[
      title url date date_parts sizes
    ]
    
    include Taggable
  end
end