class Article::Namespace < ActiveRecord::Base
  has_many :articles, :class_name => "Article::Base"
end