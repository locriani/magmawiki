# == Schema Information
# Schema version: 20100712040454
#
# Table name: wiki_sessions
#
#  id            :integer         not null, primary key
#  user_id       :integer         
#  ip_address_id :integer         
#  revision_id   :integer         
#  created_at    :datetime        
#  updated_at    :datetime        
#

class WikiSession < ActiveRecord::Base
  # This model keeps track of who editted a revision.
  belongs_to :revision
  belongs_to :user
  
  attr_accessible :ip_address, :user_id
end
