class Article < ActiveRecord::Base
  before_validation :prepare_article_name
  before_validation_on_create :prepare_first_revision
  
  # has_many :revisions
  belongs_to :current_revision, :class_name => 'Revision'
  validates_uniqueness_of :title
  
private
  def prepare_article_name
    title.downcase!
  end
  
  def prepare_first_revision
    current_revision = Revision.create(:body => "")
    current_revision.save
  end
end
