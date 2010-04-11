class Article < ActiveRecord::Base
  before_validation :prepare_article_name
  before_validation :prepare_current_revision
  
  has_many :revisions
  belongs_to :current_revision, :class_name => 'Revision'
  validates_uniqueness_of :title
  # validates_presence_of :current_revision
  
private
  def prepare_article_name
    title.downcase!
  end
  
  def prepare_current_revision
    current_revision = Revision.new(:body => "")
    current_revision.article_id = self.id
    current_revision.save!
  end
end
