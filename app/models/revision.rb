# == Schema Information
# Schema version: 20100507065544
#
# Table name: revisions
#
#  id          :integer         not null, primary key
#  body        :text            
#  article_id  :integer         
#  created_at  :datetime        
#  updated_at  :datetime        
#  summary     :string(255)     
#  approved    :boolean         
#  engine_name :string(255)     
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

  has_many :threads
  

  def self.find_all_ordered(order = nil, options = {})
    if !(order == "DESC" || order == nil)
      raise ArgumentError, "argument must be nil or DESC"
    end
    
    with_scope :find => options do
      all(:order => ["created_at ", order])
    end
  end

  def engine_proc
    p [:engine_name, engine_name]
    MARKUP_ENGINES[engine_name] or proc{|text| text}
  end

  def to_html
    engine_proc.call(body)
  end

end
