module Geni
  class Union < Base
    has_fetchable_attributes %w[
      status marriage_location marriage_date marriage_date_parts url
    ]
                
    def partners
      @partner_profiles ||= client.get_profiles(@partners.collect { |uri| uri.split('-').last })
    end
    
    def children
      @children_profiles ||= client.get_profiles(@children.collect { |uri| uri.split('-').last })
    end
  end
end