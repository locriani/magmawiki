# The article class is the interface to the most basic unit of the wiki, the revision.
# Each article maintains an ordered set of revisions, and a most current revision, which
# is displayed when an article is requested.
class Article < ActiveRecord::Base  
  has_many :revisions
  has_one :current_revision, :class_name => 'Revision', :conditions => ["is_current = ?", true]
  
  before_validation_on_create  :prepare_article_slug

  validates_presence_of :slug
  validate :slug_immutability
  
  accepts_nested_attributes_for :current_revision, :revisions
  
  attr_accessible :title
  # Rails uses to_param to construct the string for the object.
  # This *should* support unicode; but that's a theory.
  def to_param
    self.slug
  end
  
private
  def slug_immutability
    unless self.slug == escape(self.title.downcase)
      #TODO: Bad error message
      errors.add :title, "Changing the title is only for correcting capitalization and punctuation.  Perhaps you want to move the page instead?"
    end
  end
  
  def prepare_article_slug
    self.slug = escape(self.title)
  end
  
  def escape(string)
    string.downcase!
    # We don't want to stick anything that's not a number or letter in our urls
    string.gsub!(/[^a-zA-Z0-9]/, '_')
    # and we don't want to have multiple '_' in a row
    string.gsub!(/(_{2,})/, '_')
    # and strip trailing underscores
    string.chomp('_')
  end
end


