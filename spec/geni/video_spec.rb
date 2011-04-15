require 'spec_helper'

describe Geni::Video do
  before :all do
    @client = get_geni_client
    @video = Geni::Video.new({
      :id => 'video-99385',
      :client => @client
    })
  end
  
  it "has an URL" do
    @video.url.should == 'https://www.geni.com/api/video-99385'
  end
  
  it "has a title" do
    @video.title.should == 'Aurelien playing the drums'
  end
  
  it "has a creation date/time" do
    @video.created_on.should == '2011-04-15 19:16:53'
  end
  
  it "has a date" do
    @video.date.should == '4/8/2009'
  end
  
  it "has date parts" do
    @video.date_parts.should == {
      'year'  => 2009,
      'month' => 4,
      'day'   => 8
    }
  end
  
  it "has sizes" do
    @video.sizes.class.should == Hash
  end
  
  it "has tags" do
    tags = @video.tags
    tags.class.should == Array
    tags.first.class.should == Geni::Profile
    tags.first.id.should == 'profile-90990667'
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