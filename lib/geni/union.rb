module Geni
  class Union < Base
    attr_reader :id, :status, :marriage_location, :marriage_date, :marriage_date_parts
                
    def partners
      @partner_profiles ||= client.get_profile(@partners.collect { |uri| uri.split('-').last })
    end
    
    def children
      @children_profiles ||= client.get_profile(@children.collect { |uri| uri.split('-').last })
    end
  end
end