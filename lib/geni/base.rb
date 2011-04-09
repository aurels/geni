module Geni
  class Base
    attr_reader :id, :client

    def initialize(params = {})
      @id = params[:id]
      @client = params[:client]
      @fetched = params[:fetched] || false
      
      if params.has_key?(:attrs)
        params[:attrs].each_pair do |key, value|
          instance_variable_set("@#{key}", value)
        end
      end
    end
    
    def fetched?
      @fetched
    end
    
    def fetch
      client.access_token.get("/api/#{id}").each_pair do |attr, value|
        instance_variable_set("@#{attr}".to_sym, value)
      end
      @fetched = true
    end
    
    class << self
      def has_fetchable_attributes(attribute_names)
        attribute_names.each do |attribute_name|
          define_method "#{attribute_name}" do
            self.fetch unless self.fetched?
            instance_variable_get("@#{attribute_name}")
          end
        end
      end
    end
  end
end