require 'test_helper'

class ArticleTest < ActiveSupport::TestCase
  test "Article Title is Unique" do
    
    articles = []
    same_title = "STRING"
    
    articles[0] = Factory.build(:article, :title => same_title)
    articles[1] = Factory.build(:article, :title => same_title)
    
    assert articles[0].valid?
    articles[0].save!
    
    assert !(articles[1].valid?)
  end
  
  test "Article Title is not Case Sensitive (for uniqueness)" do
    
    articles = []
    same_title = "STRING"
    
    articles[0] = Factory.build(:article, :title => same_title.upcase)
    articles[1] = Factory.build(:article, :title => same_title.downcase)
    
    assert articles[0].valid?
    articles[0].save!
    
    assert !(articles[1].valid?)
  end
  
  test "Article has a current_revision" do
    article = Factory.build(:article)
    
    assert article.valid?
    article.save!
    
    assert_equal(article.current_revision, Revision.find_by_id(article.current_revision))
  end  
end
