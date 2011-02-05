# About

Simple Ruby client to the geni.com REST/OAuth API.

This library needs some specs !

# Installation

    $ gem install geni

# Example usage

    geni = Geni::Client.new({
      :app_id       => 'XX',
      :app_secret   => 'XX',
      :access_token => an_oauth_access_token
    })
    
    profile = geni.profile('an_id')
    
    puts profile.name
    puts profile.birth_date
    
    geni.parents.each do |profile|
      puts profile.name
    end
    
    geni.children.each do |profile|
      puts profile.name
    end
    
    geni.siblings.each do |profile|
      puts profile.name
    end