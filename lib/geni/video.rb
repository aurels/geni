module Geni
  class Video < Base
    has_fetchable_attributes %w[
      title url date date_parts sizes created_on
    ]
    
    include Taggable
  end
end