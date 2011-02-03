module Geni
  class Base
    def initialize(params = {})
      @access_token = params[:access_token]
      params[:attrs].each_pair do |attr, value|
        instance_variable_set("@#{attr}".to_sym, value)
      end
    end
  end
end