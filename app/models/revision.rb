# == Schema Information
# Schema version: 20100428021347
#
# Table name: revisions
#
#  id         :integer         not null, primary key
#  body       :text            
#  article_id :integer         
#  created_at :datetime        
#  updated_at :datetime        
#  summary    :string(255)     
#  is_current :boolean         
#

class Revision < ActiveRecord::Base
  belongs_to :article, :counter_cache => :revision_count
  
  def self.find_all_ordered(order = nil, options = {})
    _order = order
    _options = options
    if !(_order == "DESC" || _order == nil)
      raise ArgumentError, "argument must be nil or DESC"
    end
    
    with_scope :find => _options do
      all(:order => ["created_at ", _order])
    end
  end
end
