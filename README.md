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

I've also put [a demo Rails app](https://github.com/aurels/geni-rails-example) online to show the usage of the gem with Rails or Sinatra.

# Not done yet

+ This gem needs some specs
+ This gem only access profile and immediate family information.  I don't have a paid account, I cannot implement everything now.

# Feedback and help

Please send [me](http://aurelien.malisart.be) your feedback if you are using the Gem and have any remarks (or not).