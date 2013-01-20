class Article < ActiveRecord::Base
  has_many :revisions
  has_one :current_revision, class_name: "Article::Revision", order: "created_at DESC"

  belongs_to :namespace

  accepts_nested_attributes_for :revisions, :current_revision

  validates :title, presence: true
  validates :slug, uniqueness: true

  before_validation :slugify_title, on: :create

private
  def slugify_title
    self.slug = self.title.downcase.tr(' ','_').gsub(/[\!-\.;-@\[-\^`\{-~]/,"").gsub(/:/,":_").gsub(/(_{2,})/, '_').chomp("_")
  end
end
