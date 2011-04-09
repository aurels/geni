module Geni
  class Document < Base
    has_fetchable_attributes %w[
      title url date date_parts content_type description sizes
    ]
  
    include Taggable
  end
end