# == Schema Information
# Schema version: 20100712040454
#
# Table name: comments
#
#  id          :integer         not null, primary key
#  article_id  :integer         
#  revision_id :integer         
#  user_id     :integer         
#  subject     :string(255)     
#  body        :text            
#  created_at  :datetime        
#  updated_at  :datetime        
#  parent_id   :integer         
#  lft         :integer         
#  rgt         :integer         
#  marking_id  :integer         
#

class Comment < ActiveRecord::Base

  ## Associations
  
  belongs_to :article
  belongs_to :revision
  belongs_to :user

  has_one :marking
end