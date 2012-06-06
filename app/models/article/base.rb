class Article::Base < ActiveRecord::Base
  belongs_to :namespace
  has_many :revisions
  
  validates :title, { :uniqueness => true, :presence => true }
  validates :slug, { :uniqueness => true, :presence => true }
end