module Geni
  class User < Base
    has_fetchable_attributes %w[name]
    
    def followed_documents
    end
  end
end