require 'spec_helper'

describe Geni::Photo do
  before :all do
    @client = get_geni_client
    @photo = Geni::Photo.new(:id => 'photo-21557506', :client => @client)
    
    @client.oauth_client.connection.build do |b|
      b.adapter :test do |stub|
        stub.get('/api/photo-21557506?access_token=FAKE_OAUTH_TOKEN') do |env|
          [200, {}, get_mocked_response("https://www.geni.com/api/photo-21557506?access_token=#{get_geni_token}")]
        end
      end
    end
  end
  
  it "has a title" do
    # not given by Geni at all times
  end
  
  it "has an URL" do
    @photo.url.should == 'https://www.geni.com/api/photo-21557506'
  end
  
  it "has a date" do
    
  end
  
  it "has date parts" do
    
  end
  
  it "has a content type" do
    @photo.content_type.should == 'image/jpeg'
  end
  
  it "belongs to an album" do
    @photo.album_id.should == '44886'
  end
  
  it "has tags"
  it "can be tagged"
  it "can be untagged"
end