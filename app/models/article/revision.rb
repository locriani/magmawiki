class Article::Revision < ActiveRecord::Base
  belongs_to :article, :foreign_key => :base_id

  validates :base_id, :presence => :true
end