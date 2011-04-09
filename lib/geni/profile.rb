module Geni
  class Profile < Base

    has_fetchable_attributes %w[
      first_name middle_name maiden_name last_name suffix display_name name gender
      current_residence created_by merge_note public big_tree claimed locked birth_date
      borth_date_parts birth_location baptism_date baptism_date_parts baptism_location
      death_date death_date_parts death_location burial_date blurial_date_parts blurial_location
      url language mugshot_urls relationship is_alive
    ]

    def immediate_family
      @immediate_family ||= Geni::Family.new({
        :client => client,
        :attrs  => client.access_token.get("/api/#{id}/immediate-family")
      })
    end
    
    def parents
      immediate_family.parents
    end
    
    def father
      @father ||= parents.select { |profile| profile.gender == 'male' }.first
    end
    
    def mother
      @mother ||= parents.select { |profile| profile.gender == 'female' }.first
    end
    
    def children
      immediate_family.children
    end
    
    def siblings
      immediate_family.siblings
    end
    
    def partners
      immediate_family.partners
    end
    
    def managers
      @manager_profiles ||= @managers.collect do |profile_link|
        client.get_profile(profile_link.split('-').last)
      end
    end
    
    def merged_into
      @merged_into_profiles ||= @merged_into.to_a.collect do |profile_link|
        client.get_profile(profile_link.split('-').last)
      end
    end
    
    def requested_merges
      @requested_merges_profiles ||= @requested_merges.to_a.collect do |profile_link|
        client.get_profile(profile_link.split('-').last)
      end
    end
    
    def curator
      @curator_profile ||= @curator.nil? ? nil : client.get_profile(@curator.split('-').last)
    end
        
    def photos
      @photos ||= client.access_token.get("/api/#{id}/photos")['results'].to_a.collect do |photo_attrs|
        Geni::Photo.new({
          :client  => client,
          :attrs   => photo_attrs,
          :fetched => true
        })
      end
    end
    
    def videos
      @videos ||= client.access_token.get("/api/#{id}/videos")['results'].to_a.collect do |video_attrs|
        Geni::Photo.new({
          :client  => client,
          :attrs   => video_attrs,
          :fetched => true
        })
      end
    end
    
    def documents
      @documents ||= client.access_token.get("/api/#{id}/documents")['results'].collect do |documents_attrs|
        Geni::Photo.new({
          :client  => client,
          :attrs   => documents_attrs,
          :fetched => true
        })
      end
    end
  end
end