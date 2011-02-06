module Geni
  class Base
    attr_reader :client
    
    def initialize(params = {})
      @client = params[:client]
      params[:attrs].each_pair do |attr, value|
        instance_variable_set("@#{attr}".to_sym, value)
      end
    end
  end
end