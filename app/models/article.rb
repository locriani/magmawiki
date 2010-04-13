class Article < ActiveRecord::Base  
  before_validation :prepare_article_name
  
  has_many :revisions
  has_one :current_revision, :class_name => 'Revision', :conditions => ["is_current = ?", true]
  
  validates_uniqueness_of :title
  
  accepts_nested_attributes_for :current_revision, :revisions
  
private
  def prepare_article_name
    title.downcase!
  end
end
