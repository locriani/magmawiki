require 'test_helper'

class ArticleRevisionsTest < ActiveSupport::TestCase
  test "Article has a current_revision" do
    article = Factory.build(:article)
    
    assert article.valid?
    article.save!
    
    assert_not_nil article.current_revision, 'Article#current_revision was nil.'
    assert_equal article.current_revision, Revision.find_by_id(article.current_revision), 'This should never happen.'
  end
  
  test "Article can get a list of all revisions for that article" do
    article = Factory.build(:article)
    article.save!
    
    assert false, 'Pending'
  end
  
  test "Creating a new article revision changes the current_revision" do
    assert false, 'Pending'
  end
end