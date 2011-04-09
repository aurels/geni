require 'spec_helper'

describe Geni::Profile do
  before :all do
    @client = get_geni_client
    @profile = Geni::Profile.new(:id => 'profile-90990667', :client => @client)
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
  
  it "has managers" do
    @profile.managers.class.should == Array
  end
  
  it "has been merged into profiles" do
    @profile.merged_into.class.should == Array
  end
  
  it "has requested merges" do
    @profile.requested_merges.class.should == Array
  end
  
  it "has a curator" do
    #curator = @profile.curator
    #curator.class.should == Geni::Profile
  end
  
  it "has photos" do
    photos = @profile.photos
    photos.class.should == Array
  end
  
  it "has videos" do
    videos = @profile.videos
    videos.class.should == Array
  end
  
  it "has documents" do
    documents = @profile.documents
    documents.class.should == Array
  end
end