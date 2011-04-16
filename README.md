# About

Simple Ruby client to the [Geni](http://www.geni.com) REST/OAuth API.

# Installation

    $ gem install geni

# Example usage

    geni = Geni::Client.new({
      :app_id     => 'XX',
      :app_secret => 'XX',
      :token      => 'XX'
    })

    me = geni.get_profile
    
    profile = geni.get_profile('an_id')
    
    puts profile.name
    puts profile.birth_date
    
    profile.parents.each do |profile|
      puts profile.name
    end
    
    profile.children.each do |profile|
      puts profile.name
    end
    
    profile.siblings.each do |profile|
      puts profile.name
    end

Support is available for profiles, documents, photos, projects, unions, videos.

I've also put [a demo Rails app](https://github.com/aurels/geni-rails-example) online to show the usage of the gem with Rails or Sinatra.

# Tests

To run the specs :

    $ rake spec

All request responses are stubbed via Faraday in `spec/support/mocked_responses`.

# Feedback and help

Please send [me](http://aurelien.malisart.be) your feedback if you are using the Gem and have any remarks (or not).