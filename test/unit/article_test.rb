require 'test_helper'

class ArticleTest < ActiveSupport::TestCase
  test "Article title is unique" do
    
    articles = []
    same_title = "STRING"
    
    articles[0] = Factory.build(:article, :title => same_title)
    articles[1] = Factory.build(:article, :title => same_title)
    
    assert articles[0].valid?, 'Article was invalid on construction'
    articles[0].save!
    
    assert !(articles[1].valid?), 'Article was valid when it had a non-unique title'
  end
  
  test "Article title is not case sensitive (for uniqueness)" do
    
    articles = []
    same_title = "STRING"
    
    articles[0] = Factory.build(:article, :title => same_title.upcase)
    articles[1] = Factory.build(:article, :title => same_title.downcase)
    
    assert articles[0].valid?, 'Article was invalid on construction'
    articles[0].save!
    
    assert !(articles[1].valid?), 'Article was valid when it had a non-unique title'
  end
  
  test "Article slug is properly escaped"
  
  test "Article slug handles periods (.) properly"
end
