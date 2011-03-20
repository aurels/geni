require 'spec_helper'

token = 'iOcFgLnbL6meVc3znvrDuZ7JGeXgXRL2nQTX8vMR'
PROFILE_JSON  = `curl https://www.geni.com/api/profile-90990667?access_token=#{token}`
FAMILY_JSON   = `curl https://www.geni.com/api/profile-90990667/immediate-family?access_token=#{token}`
SIBLINGS_JSON = `curl https://www.geni.com/api/profile-90990832,90990843?access_token=#{token}`
PARENTS_JSON  = `curl https://www.geni.com/api/profile-90990739,90990730?access_token=#{token}`

FATHER_JSON   = `curl https://www.geni.com/api/profile-90990739?access_token=#{token}`
FATHER_FAMILY_JSON = `curl https://www.geni.com/api/profile-90990739/immediate-family?access_token=#{token}`

describe Geni::Profile do
  before :all do
    @geni = Geni::Client.new({
      :app_id     => 'FAKE_APP_ID',
      :app_secret => 'FAKE_APP_SECRET',
      :token      => 'FAKE_OAUTH_TOKEN'
    })
    
    @geni.oauth_client.connection.build do |b|
      b.adapter :test do |stub|
        stub.get('/api/profile-90990667?access_token=FAKE_OAUTH_TOKEN') do |env|
          [200, {'Content-Type' => 'application/json'}, PROFILE_JSON]
        end
        
        stub.get('/api/profile-profile-90990667/immediate-family?access_token=FAKE_OAUTH_TOKEN') do |env|
          [200, {'Content-Type' => 'application/json'}, FAMILY_JSON]
        end
        
        stub.get('/api/profile-90990832,90990843?access_token=FAKE_OAUTH_TOKEN') do |env|
          [200, {'Content-Type' => 'application/json'}, SIBLINGS_JSON]
        end
        
        stub.get('/api/profile-90990739,90990730?access_token=FAKE_OAUTH_TOKEN') do |env|
          [200, {'Content-Type' => 'application/json'}, PARENTS_JSON]
        end
        
        stub.get('/api/profile-90990739?access_token=FAKE_OAUTH_TOKEN') do |env|
          [200, {'Content-Type' => 'application/json'}, FATHER_JSON]
        end
        
        stub.get('/api/profile-profile-90990739/immediate-family?access_token=FAKE_OAUTH_TOKEN') do |env|
          [200, {'Content-Type' => 'application/json'}, FATHER_FAMILY_JSON]
        end
      end
    end
  end
    
  it "has retrievable basic informations" do
    stub_request(:get, 'https://www.geni.com/api/profile-90990667?access_token=FAKE_OAUTH_TOKEN').to_return({
      :body => PROFILE_JSON
    })
    
    profile = @geni.get_profile(90990667)
    
    profile.class.should == Geni::Profile
    profile.name.should == "Aurélien Malisart"
    profile.url.should == "https://www.geni.com/api/profile-90990667"
    profile.birth_date_parts['year'].should == 1986
  end
  
  it "has siblings" do
    profile = @geni.get_profile(90990667)
    profile.siblings.should have(2).items
    profile.siblings[0].name.should == 'Timothy Malisart'
  end
  
  it "has parents" do
    profile = @geni.get_profile(90990667)
    profile.parents.should have(2).items
    profile.father.name.should == 'Alain Malisart'
    profile.mother.name.should == 'Carole MOINY'
  end
  
  it "has children" do
    profile = @geni.get_profile(90990739)
    profile.children.should have(3).items
    profile.children[2].name.should == 'Benjamin Malisart'
  end
  
  it "has partners" do
    profile = @geni.get_profile(90990739)
    profile.partners.should have(1).items
    profile.partners[0].name.should == 'Carole MOINY'
  end
end