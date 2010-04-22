class Revision < ActiveRecord::Base
  belongs_to :article, :counter_cache => :revision_count
  
  def self.find_all_ordered(order = nil, options = {})
    if !(order == "DESC" || order == nil)
      throw "oops" #TODO: Throw a real error, duufus
    end
    
    with_scope :find => options do
      all(:order => ["created_at ", order])
    end
  end
end
