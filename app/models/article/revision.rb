class Article::Revision < ActiveRecord::Base
  belongs_to :article

  validates :article_id, :presence => :true
end