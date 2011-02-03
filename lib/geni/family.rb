module Geni
  class Family < Base
    attr_reader :nodes
        
    def profiles
      @nodes.keys.select { |id| id =~ /^profile-/ }
    end
    
    def unions
      @nodes.keys.select { |id| id =~ /^union-/ }
    end
    
    def debug
      
    end
  end
end