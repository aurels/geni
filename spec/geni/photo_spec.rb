require 'spec_helper'

describe Geni::Photo do
  before :all do
    @client = get_geni_client
    @photo = Geni::Photo.new(:id => 'photo-22466661', :client => @client)
  end
  
  it "has a title" do
    # not given by Geni at all times
  end
  
  it "has an URL" do
    @photo.url.should == 'https://www.geni.com/api/photo-22466661'
  end
  
  it "has a creation date/time" do
    @photo.created_on.should == '2011-01-23 00:01:18'
  end
  
  it "has a date" do
    @photo.date.should == '4/17/2010'
  end
  
  it "has date parts" do
    @photo.date_parts.should == {
      'day'   => 17,
      'month' => 4,
      'year'  => 2010
    }
  end
  
  it "has a content type" do
    @photo.content_type.should == 'image/jpeg'
  end
  
  it "belongs to an album" do
    @photo.album_id.should == '6000000009078813207'
  end
  
  it "has sizes" do
    @photo.sizes.class.should == Hash
    @photo.sizes.keys.should include('thumb')
    @photo.sizes.keys.should include('original')
    @photo.sizes.keys.should include('large')
    @photo.sizes.keys.should include('medium')
    @photo.sizes.keys.should include('small')
    @photo.sizes.keys.should include('thumb2')
  end
  
  it "has tags" do
    tags = @photo.tags
    tags.class.should == Array
    tags.first.class.should == Geni::Profile
    tags.first.id.should == 'profile-90990889'
  end
  
  it "can be tagged" do
    # FIXME
    pending
  end
  
  it "can be untagged" do
    # FIXME
    pending
  end
end