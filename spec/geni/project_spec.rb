require 'spec_helper'

describe Geni::Project do
  before :all do
    @client = get_geni_client
    @project = Geni::Project.new(:id => 'project-6', :client => @client)
    
    @client.oauth_client.connection.build do |b|
      b.adapter :test do |stub|
        stub.get('/api/project-6?access_token=FAKE_OAUTH_TOKEN') do |env|
          [200, {}, get_mocked_response("https://www.geni.com/api/project-6?access_token=#{get_geni_token}")]
        end
      end
    end
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

  it "has collaborators"
  it "has profiles"
  it "has followers"
end