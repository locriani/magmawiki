# == Schema Information
# Schema version: 20100513034408
#
# Table name: comments
#
#  id         :integer         not null, primary key
#  user_id    :integer         
#  topic_id   :integer         
#  subject    :string(255)     
#  body       :text            
#  parent_id  :integer         
#  left       :integer         
#  right      :integer         
#  created_at :datetime        
#  updated_at :datetime        
#

class Comment < ActiveRecord::Base
  belongs_to :topic

  acts_as_nested_set(
    :parent_column  => "parent_id",
    :left_column    => "left",
    :right_column   => "right",
    :scope          => "topic_id"
  )
end
