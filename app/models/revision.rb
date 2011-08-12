# == Schema Information
# Schema version: 20100712040454
#
# Table name: revisions
#
#  id          :integer         not null, primary key
#  body        :text            
#  article_id  :integer         
#  created_at  :datetime        
#  updated_at  :datetime        
#  summary     :string(255)     
#  engine_name :string(255)     
#  approved    :boolean         
#

MARKUP_ENGINES = {

  "wikicloth" => proc do |revision|
    WikiParser.new(
    :data => revision.body,
    :params => {
      :pagename => revision.slug,
      "PAGENAME" => revision.title
    }
    ).to_html
  end,

  'markdown' => proc do |revision|
    RDiscount.new(revision.body).to_html
  end,

  'textile' => proc do |revision|
    RedCloth.new(revision.body).to_html
  end,

}

class Revision < ActiveRecord::Base

  belongs_to  :article,       :counter_cache => :revision_count
  has_many    :revisions,     :through => :article_id
  has_one     :wiki_session
  has_many    :threads

  def slug; article.slug; end
  def title; article.title; end

  def next
    Revision.first(:conditions=>["article_id = ? and updated_at > ?", article_id, updated_at])
  end

  def prev
    Revision.first(:conditions=>["article_id = ? and updated_at < ?", article_id, updated_at])
  end

  def markup_proc
    unless result = MARKUP_ENGINES[engine_name]
      Rails.logger.warn "Warning: Revision is trying to use a nonexistant engine (#{engine_name.inspect})"
      result = proc { |article| article.body }
    end

    result
  end

  def to_html
    markup_proc.call(self)
  end

  def prev_diff
    prev ? diff_against(prev) : to_html
  end

  #
  # Diff method  #TODO: Wait seriously, why are we using python and popen for a ruby project?
  #

end
