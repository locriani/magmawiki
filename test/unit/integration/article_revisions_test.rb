require 'test_helper'

class ArticleRevisionsTest < ActiveSupport::TestCase
  test "Article has an intial revision on article creation" do
    article = Factory.build(:article)
    article.save!
    
    assert_same article.current_revision, Revision.find_by_id(article.current_revision)
  end
end