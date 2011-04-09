require 'spec_helper'

describe Geni::Video do
  before :all do
    @client = get_geni_client
    @video = Geni::Video.new({
      :id => 'video-1',
      :client => @client
    })
  end
  
  it "has an URL" do
    @video.url.should == 'https://www.geni.com/api/video-1'
  end
  
  it "has a title" do
    
  end
  
  it "has a date" do
    # FIXME
  end
  
  it "has date parts" do
    # FIXME
  end
  
  it "has sizes" do
    # FIXME
  end
  
  it "has tags" do
    # FIXME
  end
  
  it "can be tagged" do
    # FIXME
  end
  
  it "can be untagged" do
    # FIXME
  end
end