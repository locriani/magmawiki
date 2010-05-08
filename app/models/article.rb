# == Schema Information
# Schema version: 20100507065544
#
# Table name: articles
#
#  id             :integer         not null, primary key
#  title          :string(255)     
#  talk_forum_id  :integer         
#  created_at     :datetime        
#  updated_at     :datetime        
#  slug           :string(255)     
#  lock_version   :integer         default(0), not null
#  revision_count :integer         default(0), not null
#

# The article class is the interface to the most basic unit of the wiki, the revision.
# Each article maintains an ordered set of revisions, and a most current revision, which
# is displayed when an article is requested.
class Article < ActiveRecord::Base  
  has_many :revisions
  has_one :current_revision, :class_name => 'Revision', :conditions => ["is_current = ?", true]
  
  before_validation_on_create  :prepare_article_slug

  validates_presence_of   :title
  validates_presence_of   :slug
  validates_uniqueness_of :slug
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
    unless self.slug == escape(self.title)
      #TODO: Bad error message, i18n
      errors.add :title, (I18n.t 'article.slug_error')
    end
  end
  
  def prepare_article_slug
    self.slug = escape(self.title)
  end
  
  def escape(input_string)
    output_string = input_string.downcase
    # We don't want to stick anything that's not a number or letter in our urls
    output_string.gsub!(/[^a-zA-Z0-9]/, '_')
    # and we don't want to have multiple '_' in a row
    output_string.gsub!(/(_{2,})/, '_')
    # and strip trailing underscores
    output_string.chomp('_')
  end
end


