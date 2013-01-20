class Article::Revision < ActiveRecord::Base
  belongs_to :article
  belongs_to :editor

  validates :edit_summary, presence: true
  validates :body, presence: true
end
