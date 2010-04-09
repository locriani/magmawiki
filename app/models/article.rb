class Article < ActiveRecord::Base
  has_many :revisions
  
  validates_uniqueness_of :title
end
