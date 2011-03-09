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

#TODO: This should be extracted out.
MARKUP_ENGINES = {
  "wikicloth" => proc do |body, article_id|
    WikiParser.new(
	  :data => body,
	  :params => {
	    :pagename => Article.find_by_id(article_id).slug, 
		  "PAGENAME" => Article.find_by_id(article_id).title
	  }
    ).to_html
  end
}

class Revision < ActiveRecord::Base

  belongs_to :article, :counter_cache => :revision_count
  has_one :wiki_session
  has_many :revisions, :through => :article_id
  has_many :threads

  def next
    Revision.first(:conditions=>["article_id = ? and updated_at > ?", article_id, updated_at])
  end

  def prev
    Revision.first(:conditions=>["article_id = ? and updated_at < ?", article_id, updated_at])
  end

  def markup_proc
    unless result = MARKUP_ENGINES[engine_name]
      Rails.logger.warn "Warning: Revision is trying to use a nonexistant engine (#{engine_name.inspect})"
      result = proc { |text| text }
    end

    result
  end

  def to_html
    markup_proc.call(body, article_id)
  end

  def prev_diff
    prev ? diff_against(prev) : to_html
  end

  #
  # Diff method  #TODO: Wait seriously, why are we using python and popen for a ruby project?
  #
  require 'tempfile'
  require 'open3'
  def diff_against(other)
    a = other.body
    b = self.body

    #Differ.diff_by_word(a, b)
    #xhtml_diff(a, b)

    tmpfiles = [a,b].map do |doc|
      f = Tempfile.open("diff")
      f.write(doc)
      f.flush
      f
    end

    args    = ["python", "lib/diff.py", *tmpfiles.map(&:path)]
    result  = Open3.popen3(*args) { |stdin, stdout, stderr| stdout.read }

    tmpfiles.each{|f| f.unlink}

    result
  end

#  def xhtml_diff(doc_a, doc_b)
#    a = REXML::HashableElementDelegator.new(REXML::Document.new(doc_a))
#    b = REXML::HashableElementDelegator.new(REXML::Document.new(doc_b))
#
#    result = XHTMLDiff.diff(a,b)
#    result.to_s
#  end

end
