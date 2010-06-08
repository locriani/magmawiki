# == Schema Information
# Schema version: 20100513034408
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
  "wikicloth" => proc do |body|
    WikiCloth::WikiCloth.new(
      :data=>body, 
      :link_handler=>CustomLinkHandler.new,
      :params=>{}  # template variables
    ).to_html
  end
}


# TODO: Put this code somewhere else!
class CustomLinkHandler < WikiCloth::WikiLinkHandler

  def url_for(page)
    #"javascript:alert('You clicked on: #{page}');"
    page
  end

  def link_attributes_for(page)
     { :href => url_for(page) }
  end

end

class Revision < ActiveRecord::Base

  belongs_to :article, :counter_cache => :revision_count
  has_many :revisions, :through => :article
  has_many :threads

  def self.find_all_ordered(order = nil, options = {})
    if !(order == "DESC" || order == nil)
      raise ArgumentError, "argument must be nil or DESC"
    end
    
    with_scope :find => options do
      all(:order => ["created_at ", order])
    end
  end

  def next
    Revision.first(:conditions=>["article_id = ? and updated_at > ?", article_id, updated_at])
  end

  def prev
    Revision.first(:conditions=>["article_id = ? and updated_at < ?", article_id, updated_at])
  end

  def markup_proc
    unless result = MARKUP_ENGINES[engine_name]
      puts "Warning: Revision is trying to use a nonexistant engine (#{engine_name.inspect})"
      result = proc { |text| text }
    end

    result
  end

  def to_html
    markup_proc.call(body)
  end

  def prev_diff
    prev ? diff_against(prev) : to_html
  end

  #
  # Diff method
  #
  require 'tempfile'
  require 'open3'
  def diff_against(other)
    a = other.to_html
    b = self.to_html

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
