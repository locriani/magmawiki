require 'spec_helper'
require 'nokogiri'

describe TabHeadersHelper do
  shared_examples_for 'all tabs' do
    it 'should generate well formed html' do
      
    end
    it 'should properly output position class'
    it 'should accept active-state class'
  end
  
  context 'article' do
    it_should_behave_like 'all tabs'
    
    it 'should link to the proper article'
  end
  
  context 'talk forum' do
    it_should_behave_like 'all tabs'
    
    it 'should link to the proper talk forum'
  end
end