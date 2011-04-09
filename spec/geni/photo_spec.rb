require 'spec_helper'

describe Geni::Photo do
  before :all do
    @client = get_geni_client
    @photo = Geni::Photo.new(:id => 'photo-21557506', :client => @client)
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