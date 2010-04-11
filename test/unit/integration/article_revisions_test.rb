require 'test_helper'

class ArticleRevisionsTest < ActiveSupport::TestCase
  test "Article has an intial revision on article creation" do
    article = Factory.build(:article)
    article.save!
    
    assert_same article.current_revision, Revision.find_by_id(article.current_revision)
  end
  
  test "Article can get a list of all revisions for that article" do
    article = Factory.build(:article)
    article.save!
    
    assert false
  end
  
  test "Creating a new article revision changes the current_revision" do
    assert false
  end
end