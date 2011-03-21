require 'spec_helper'

token = 'iOcFgLnbL6meVc3znvrDuZ7JGeXgXRL2nQTX8vMR'

describe Geni::Family do
  before :all do
    @client = Geni::Client.new({
      :app_id     => 'FAKE_APP_ID',
      :app_secret => 'FAKE_APP_SECRET',
      :token      => 'FAKE_OAUTH_TOKEN'
    })
    
    @client.oauth_client.connection.build do |b|
      b.adapter :test do |stub|
        stub.get('/api/profile-90990739?access_token=FAKE_OAUTH_TOKEN') do |env|
          [200, {'Content-Type' => 'application/json'}, `curl https://www.geni.com/api/profile-90990739?access_token=#{token}`]
        end
        
        stub.get('/api/profile-90990739/immediate-family?access_token=FAKE_OAUTH_TOKEN') do |env|
          [200, {'Content-Type' => 'application/json'}, `curl https://www.geni.com/api/profile-90990739/immediate-family?access_token=#{token}`]
        end
        
        # Parents
        stub.get('/api/profile-90990897,90990889?access_token=FAKE_OAUTH_TOKEN') do
          [200, {}, `curl https://www.geni.com/api/profile-90990897,90990889?access_token=#{token}`]
        end
        
        # Partners
        stub.get('/api/profile-90990730?access_token=FAKE_OAUTH_TOKEN') do
          [200, {}, `curl https://www.geni.com/api/profile-90990730?access_token=#{token}`]
        end
        
        # Children
        stub.get('/api/profile-90990832,90990843,90990667?access_token=FAKE_OAUTH_TOKEN') do
          [200, {}, `curl https://www.geni.com/api/profile-90990832,90990843,90990667?access_token=#{token}`]
        end
        
        # Siblings
        stub.get('/api/profile-90990985,90990977,90990923,90990957?access_token=FAKE_OAUTH_TOKEN') do
          [200, {}, `curl https://www.geni.com/api/profile-90990985,90990977,90990923,90990957?access_token=#{token}`]
        end
      end
    end
  end
  
  it 'has parents' do
    family = @client.get_profile('90990739').immediate_family
    family.parents.should have(2).items
    family.parents[0].name.should == 'Simon Moiny'
    family.parents[1].name.should == 'Arlette PAIX'
  end
  
  it 'has partners' do
    family = @client.get_profile('90990739').immediate_family
    family.partners.should have(1).items
    family.partners[0].name.should == 'Alain Malisart'
  end
  
  it 'has children' do
    family = @client.get_profile('90990739').immediate_family
    family.children.should have(3).items
    
    child_names = family.children.collect(&:name)
    
    child_names.should include('Aurélien Malisart')
    child_names.should include('Timothy Malisart')
    child_names.should include('Benjamin Malisart')
  end
  
  it 'has siblings' do
    family = @client.get_profile('90990739').immediate_family
    family.siblings.should have(4).items
    
    sibling_names = family.siblings.collect(&:name)
    
    sibling_names.should include('Fabienne Moiny')
    sibling_names.should include('Bérengère MOINY')
    sibling_names.should include('Luc Moiny')
    sibling_names.should include('Armelle MOINY')
  end
end