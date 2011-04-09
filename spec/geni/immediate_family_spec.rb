require 'spec_helper'

describe Geni::Profile::ImmediateFamily do
  before :all do
    @client = get_geni_client
    @family = @client.get_profile('profile-90990739').immediate_family
  end
  
  it 'has a focus node' do
    @family.focus.class.should == Hash
    @family.focus['id'].should == 'profile-90990739'
  end
  
  it 'has parents' do
    @family.parents.should have(2).items
    @family.parents[0].name.should == 'Simon Moiny'
    @family.parents[1].name.should == 'Arlette PAIX'
  end
  
  it 'has partners' do
    @family.partners.should have(1).items
    @family.partners[0].name.should == 'Alain Malisart'
  end
  
  it 'has children' do
    @family.children.should have(3).items
    
    child_names = @family.children.collect(&:name)
    
    child_names.should include('Aurélien Malisart')
    child_names.should include('Timothy Malisart')
    child_names.should include('Benjamin Malisart')
  end
  
  it 'has siblings' do
    @family.siblings.should have(4).items
    
    sibling_names = @family.siblings.collect(&:name)
    
    sibling_names.should include('Fabienne Moiny')
    sibling_names.should include('Bérengère MOINY')
    sibling_names.should include('Luc Moiny')
    sibling_names.should include('Armelle MOINY')
  end
end