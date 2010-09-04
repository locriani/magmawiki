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

  # Docs:
  #   http://rdoc.info/rdoc/collectiveidea/awesome_nested_set/blob/b9aba888f5f28e7ce47af4a36c2ae1df17640b38/CollectiveIdea/Acts/NestedSet/InstanceMethods.html

  acts_as_nested_set(
    :parent_column  => "parent_id",
    :left_column    => "left",
    :right_column   => "right",
    :scope          => "topic_id"
  )

end
