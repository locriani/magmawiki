class Topic < ActiveRecord::Base
  has_many :comments

  belongs_to :article
  belongs_to :revision
  belongs_to :user
end

class InlineTopic < Topic
end
