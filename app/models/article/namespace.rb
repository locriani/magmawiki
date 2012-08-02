class Article::Namespace < ActiveRecord::Base
  has_many :articles, :class_name => "Article::Base"
  validates :slug, :uniqueness => true
end