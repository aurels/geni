require 'spec_helper'

describe Geni::Client do
  before :all do
    @client = get_geni_client
  end
  
  it "has an authorize URL" do
    #puts @client.authorize_url
  end
  
  it "has an OAuth2 access token" do
    @client.access_token.class.should == OAuth2::AccessToken
  end
  
  it "has an OAuth2 callback URL" do
    
  end
  
  it "can get current user's profile" do
    profile = @client.me
    profile.class.should == Geni::Profile
    profile.id.should == 'profile-90990667'
  end
  
  it "can get a single profile" do
    profile = @client.get_profile('profile-90990667')
    profile.class.should == Geni::Profile
    profile.id.should == 'profile-90990667'
  end
  
  it "can get multiple profiles" do
    profiles = @client.get_profiles(['profile-90990667', 'profile-90990668'])
    profiles.class.should == Array
    profiles.should have(2).items
    profiles.collect(&:id).should include('profile-90990667')
  end
    
  it "can get a union" do
    union = @client.get_union('union-12276689')
    union.class.should == Geni::Union
    union.id.should == 'union-12276689'
  end
    
  it "can get a photo" do
    photo = @client.get_photo('photo-21557506')
    photo.class.should == Geni::Photo
    photo.id.should == 'photo-21557506'
  end
  
  it "can get a project" do
    project = @client.get_project('project-6')
    project.class.should == Geni::Project
    project.id.should == 'project-6'
  end
  
  it "can get a document" do
    document = @client.get_document('document-339953')
    document.class.should == Geni::Document
    document.id.should == 'document-339953'
  end
end