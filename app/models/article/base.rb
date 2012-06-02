class Article::Base < ActiveRecord::Base
  has_many :revisions
  
  validates :title, { :uniqueness => true, :presence => true }
end