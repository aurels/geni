require 'spec_helper'

describe Geni::Union do
  before :all do
    @client = get_geni_client
    @union = Geni::Union.new(:id => 'union-12276689', :client => @client)
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
    partners = @union.partners
    partners.class.should == Array
    partners.first.class.should == Geni::Profile
  end
  
  it 'has children' do
    children = @union.children
    children.class.should == Array
    children.should be_empty
  end
end