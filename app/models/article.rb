class Article < ActiveRecord::Base
  before_validation :prepare_article_name
  
  has_many :revisions
  validates_uniqueness_of :title
  
private
  def prepare_article_name
    title.downcase!
  end
end
