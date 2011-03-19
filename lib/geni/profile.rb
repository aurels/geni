module Geni
  class Profile < Base
    attr_reader :id
    attr_reader :first_name, :middle_name, :maiden_name, :last_name, :suffix, :display_name, :name
    attr_reader :gender
    attr_reader :current_residence
    attr_reader :created_by
    attr_reader :merge_note
    attr_reader :public
    attr_reader :big_tree
    attr_reader :claimed
    attr_reader :locked
    attr_reader :birth_date, :birth_date_parts, :birth_location
    attr_reader :baptism_date, :baptism_date_parts, :baptism_location
    attr_reader :death_date, :death_date_parts, :death_location
    attr_reader :burial_date, :blurial_date_parts, :blurial_location
    attr_reader :url
    attr_reader :language
    attr_reader :mugshot_urls
    attr_reader :relationship
    attr_reader :is_alive
    
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

    def immediate_family
      @immediate_family ||= Geni::Family.new({
        :client => client,
        :attrs  => client.access_token.get("/api/profile-#{id}/immediate-family")
      })
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
    
    def merge
      # FIXME
    end
    
    def merges
    end
    
    def data_conflicts
    end
    
    def tree_conflicts
    end
    
    def tree_matches
    end
    
    def photos
      @profiles ||= client.access_token.get("/api/#{id}/photos")['results'].collect do |photo_attrs|
        Geni::Photo.new({
          :client => client,
          :attrs  => photo_attrs
        })
      end
    end
    
    def videos
      @videos ||= client.access_token.get("/api/#{id}/videos")['results'].collect do |video_attrs|
        Geni::Photo.new({
          :client => client,
          :attrs  => video_attrs
        })
      end
    end
    
    def documents
      @documents ||= client.access_token.get("/api/#{id}/documents")['results'].collect do |documents_attrs|
        Geni::Photo.new({
          :client => client,
          :attrs  => documents_attrs
        })
      end
    end
  end
end