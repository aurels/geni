module Geni
  class Union < Base
    has_fetchable_attributes %w[
      id status marriage_location marriage_date marriage_date_parts
    ]
                
    def partners
      @partner_profiles ||= client.get_profile(@partners.collect { |uri| uri.split('-').last })
    end
    
    def children
      @children_profiles ||= client.get_profile(@children.collect { |uri| uri.split('-').last })
    end
  end
end