# == Schema Information
# Schema version: 20100513034408
#
# Table name: topics
#
#  id          :integer         not null, primary key
#  article_id  :integer         
#  revision_id :integer         
#  user_id     :integer         
#  subject     :string(255)     
#  type        :string(255)     
#  status      :string(255)     
#  tagged_text :string(255)     
#  tag_start   :integer         
#  tag_end     :integer         
#  created_at  :datetime        
#  updated_at  :datetime        
#

class Topic < ActiveRecord::Base
  has_many :comments

  belongs_to :article
  belongs_to :revision
  belongs_to :user
end

class InlineTopic < Topic
end
