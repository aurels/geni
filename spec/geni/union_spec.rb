require 'spec_helper'

describe Geni::Union do
  before :all do
    @client = get_geni_client
    @union = Geni::Union.new(:id => 'union-12276689', :client => @client)
    
    @client.oauth_client.connection.build do |b|
      b.adapter :test do |stub|
        stub.get('/api/union-12276689?access_token=FAKE_OAUTH_TOKEN') do |env|
          [200, {}, get_mocked_response("https://www.geni.com/api/union-12276689?access_token=#{get_geni_token}")]
        end
      end
    end
  end
  
  it "has a status" do
    @union.status.should == 'current'
  end
  
  it "has a marriage location" do
    @union.marriage_location.should == 'Chicago, Illinois, United States'
  end
  
  it "has a marriage date" do
    @union.marriage_date.should == '10/18/1992'
  end
  
  it "has marriage date parts" do
    @union.marriage_date_parts.should == {
      'day'   => 18,
      'month' => 10,
      'year'  => 1992
    }
  end
  
  it "has an URL" do
    @union.url.should == 'https://www.geni.com/api/union-12276689'
  end
    
  it 'has partners' do
  end
  
  it 'has children' do
  end
end