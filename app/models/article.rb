# The article class is the interface to the most basic unit of the wiki, the revision.
# Each article maintains an ordered set of revisions, and a most current revision, which
# is displayed when an article is requested.
class Article < ActiveRecord::Base  
  before_validation :prepare_article_name, :prepare_article_slug
  
  has_many :revisions
  has_one :current_revision, :class_name => 'Revision', :conditions => ["is_current = ?", true]
  
  validates_uniqueness_of :title
  validates_presence_of :slug
  
  accepts_nested_attributes_for :current_revision, :revisions
  
  # Rails uses to_param to construct the string for the object.
  # This *should* support unicode; but that's a theory.
  def to_param
    self.slug
  end
  
private
  def prepare_article_name
    self.title.downcase!
  end
  
  def prepare_article_slug
    self.slug = escape(self.title.downcase)
  end
  
  def escape(string)
    # We don't want to URL encode spaces, commas, or semicolons
    string.gsub!(/[^a-zA-Z0-9]/, '_')
    # and we don't want to have multiple '_' in a row
    string.gsub!(/(_{2,})/, '_')
    # and strip trailing underscores
    string.chomp('_')
  end
end


