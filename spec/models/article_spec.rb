require 'spec_helper'

describe Article do
  context 'slugs' do
    it 'should strip out non a-zA-Z0-9 characters' do
      title = "ésomething!~"
      article = Factory.create(:article, :title => title)
      
      article.slug["!"].should be_nil
      article.slug["~"].should be_nil
      article.slug["é"].should be_nil
    end
    
    it 'should strip out double underscore characters' do
      title = "DOUBLE__UNDERSCORE"      
      article = Factory.create(:article, :title => title)
      
      article.slug["__"].should be_nil
    end
    
    it 'should be downcased' do
      title = "UPPER CASE"
      article = Factory.create(:article, :title => title)
      
      article.slug.downcase.should be_eql(article.slug)
    end
    
    it 'should remove trailing underscores' do
      title = "Somethingwithtrailingunderscores_"
      article = Factory.create(:article, :title => title)
      
      article.slug["_"].should be_nil
      
      title = "Something with trailing underscores_!!!"
      article = Factory.create(:article, :title => title)
      
      article.slug.reverse[0,1]["_"].should be_nil
    end
    
    it 'should replace any sequence of non a-zA-Z0-9 characters with an underscore' do
      title = "exclamation!!!point.THIS_()()is a test"
      article = Factory.create(:article, :title => title)
      
      article.slug["!"].should be_nil
      article.slug["("].should be_nil
      article.slug[")"].should be_nil
      article.slug[" "].should be_nil
      article.slug[11,1]["_"].should_not be_nil
    end
    
    it 'should be immutable' do
      title = Hash.new
      title['original'] = "testing a slug" # Expected slug "testing_a_slug"
      title['valid']    = "teSTing_a_slug!" # Expected slug "testing_a_slug"
      title['invalid']  = "testing_a_catg" # Expected slug "testing_a_catg"
      
      article = Factory.create(:article, :title => title['original'])
      
      article.title = title['valid']
      article.should be_valid
      
      article.title = title['invalid']
      article.should_not be_valid
    end
    
    it 'should be unique' do
      title = "same title" # Expected slug "same_slug"
      
      Factory.create(:article, :title => title)
      article = Factory.build(:article, :title => title)
      
      lambda { article.save }.should raise_error(ActiveRecord::StatementInvalid)
    end
  end
  
  context 'titles' do
    it 'should be muteable' do
      title = Hash.new
      title['original'] = "Some title."
      title['valid']    = "Some !titlE!!!!~@)!(*#)"
      
      article = Factory.create(:article, :title => title['original'])
      article.title = title['valid']
      
      article.should be_valid
    end
  end
end
