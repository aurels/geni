require 'spec_helper'

describe Geni::Document do
  before :all do
    @client = get_geni_client
    @document = Geni::Document.new(:id => 'document-339953', :client => @client)
  end
  
  it "has a title" do
    @document.title.should == 'Jaworow AGAD Births 1877-96'
  end
  
  it "has a url" do
    @document.url.should == 'https://www.geni.com/api/document-339953'
  end
  
  it "has a date" do

  end
  
  it "has date_parts" do
    @document.date_parts.should == {}
  end
  
  it "has a content_type" do
    @document.content_type.should == 'image/png'
  end
  
  it "has a description" do
    @document.description.should == "Jewish Records Indexing - Poland\nhttp://www.jewishgen.org/jri-pl/index.htm"
  end
  
  it "has sizes" do
  end
  
  it "has tags" do
    tags = @document.tags
  end
  
  it "can be tagged" do
  end
  
  it "can be untagged" do
  end
end