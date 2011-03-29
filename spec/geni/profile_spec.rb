require 'spec_helper'

describe Geni::Profile do
  before :all do
    @client = get_geni_client
    @profile = Geni::Profile.new(:id => 'profile-90990667', :client => @client)
    
    @client.oauth_client.connection.build do |b|
      b.adapter :test do |stub|
        stub.get('/api/profile-90990667?access_token=FAKE_OAUTH_TOKEN') do |env|
          [200, {}, get_mocked_response("https://www.geni.com/api/profile-90990667?access_token=#{get_geni_token}")]
        end
        
        stub.get('/api/profile-90990667/immediate-family?access_token=FAKE_OAUTH_TOKEN') do |env|
          [200, {}, get_mocked_response("https://www.geni.com/api/profile-90990667/immediate-family?access_token=#{get_geni_token}")]
        end
      end
    end
  end
  
  it "is not fetched by default" do
    @profile.should_not be_fetched
  end
    
  it "is fetchable" do
    @profile.fetch
    @profile.should be_fetched
  end
  
  it "has a name" do
    @profile.name.should == "Aurélien Malisart"
  end
  
  it "has a birth date" do
    @profile.birth_date.should == "6/30/1986"
  end
  
  it "is alive" do
    @profile.is_alive.should == true
  end
  
  it "has an immediate family" do
    family = @profile.immediate_family
    family.class.should == Geni::Family
  end
  
  it "has managers"
  it "has been merged into profiles"
  it "has requested merges"
  it "has a curator"
  
  it "has photos"
  it "has videos"
  it "has documents"
end