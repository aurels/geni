require 'spec_helper'

describe Geni::Project do
  before :all do
    @client = get_geni_client
    @project = Geni::Project.new(:id => 'project-6', :client => @client)
  end
  
  it "has a name" do
    @project.name.should == 'Magna Carta Sureties and Witnesses'
  end
  
  it "has a description" do
    @project.description.should_not == ''
  end
  
  it "has an URL" do
    @project.url.should == 'https://www.geni.com/api/project-6'
  end

  it "has collaborators" do
    collaborators = @project.collaborators
    collaborators.class.should == Array
    collaborators.collect(&:id).should include('profile-34069147')
    collaborators.first.class.should == Geni::Profile
    collaborators.first.should be_fetched
  end
  
  it "has profiles" do
    profiles = @project.profiles
    profiles.class.should == Array
    profiles.collect(&:id).should include('profile-37184377')
    profiles.first.class.should == Geni::Profile
    profiles.first.should be_fetched
  end
  
  it "has followers" do
    followers = @project.followers
    followers.class.should == Array
    followers.collect(&:id).should include('profile-34069147')
    followers.first.class.should == Geni::Profile
    followers.first.should be_fetched
  end
end