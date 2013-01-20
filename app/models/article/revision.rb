class Article::Revision < ActiveRecord::Base
  belongs_to :article
  belongs_to :editor

  validates :edit_summary, presence: true
  validates :body, presence: true

  def to_html
    WikiParser.new(
      data: self.body,
      params: {
        pagename: self.article.slug,
        "PAGENAME" => self.article.title
      }
    ).to_html.html_safe
  end
end
