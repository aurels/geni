module Geni
  class ResultSet
    
    attr_reader :results
    
    def initialize(data)
      if data.has_key?('results')
        @results = data['results']
      else
        @results = [data]
      end
    end
  end
end