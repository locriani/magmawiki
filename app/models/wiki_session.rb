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
  # This model does automagical wonderful things to link our different session types
  # to a revision (future: or a comment).
  
  # We can have:
  # IP Address ONLY sessions (no cookies)
  # IP + Cookie
  # User
  
  belongs_to :revision
  belongs_to :user
end
