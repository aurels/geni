module Geni
  class Project < Base
    has_fetchable_attributes %w[name description url]
    
    ['collaborators', 'profiles', 'followers'].each do |relation_name|
      define_method relation_name do
        if instance_variable_get("@#{relation_name}").nil?
          profile_ids = client.access_token.get("/api/#{id}/#{relation_name}")['results'].collect do |profile|
            profile['id'].split('-').last
          end
          
          instance_variable_set("@#{relation_name}", client.get_profile(profile_ids))
        else
          instance_variable_get("@#{relation_name}")
        end
      end
    end
  end
end