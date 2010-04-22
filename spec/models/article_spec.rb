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
  end
end
