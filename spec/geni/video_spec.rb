require 'spec_helper'

describe Geni::Video do
  before :all do
    @client = get_geni_client
    @video = Geni::Video.new(:id => 'video-1', :client => @client)
  end
  
  it "has a title" do
    
  end
  
  it "has a date" do
    #@video.created_on.should == '2008-07-23 19:33:22'
  end
  
  it "has date parts" do
    
  end
  
  it "has sizes" do
    
  end
  
  it "has tags" do
    #tags = @video.tags
  end
  
  it "can be tagged" do
    
  end
  
  it "can be untagged" do
    
  end
end