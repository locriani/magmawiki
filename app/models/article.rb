# The article class is the interface to the most basic unit of the wiki, the revision.
# Each article maintains an ordered set of revisions, and a most current revision, which
# is displayed when an article is requested.
class Article < ActiveRecord::Base  
  before_validation :prepare_article_name, :prepare_article_slug
  
  has_many :revisions
  has_one :current_revision, :class_name => 'Revision', :conditions => ["is_current = ?", true]
  
  validates_uniqueness_of :title
  
  accepts_nested_attributes_for :current_revision, :revisions
  
  # Rails uses to_param to construct the string for the object.
  # This is not currently a portable implementation (doesn't handle accented characters), so it will need work.
  def to_param
    # TODO: Clean this up for full unicode support.
    "#{title}".gsub(/[^a-z0-9]+/i, '_')
  end
private
  def prepare_article_name
    title.downcase!
  end
  
  def prepare_article_slug
    #TODO: Factor this out, this is gross. (DRY)
    slug = title.downcase.gsub(/[^a-z0-9]+/i, '_')
  end
end
