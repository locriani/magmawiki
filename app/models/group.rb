class Group < ActiveRecord::Base
  has_many :permissions, :dependent => :destroy
  has_many :restrictions, :dependent => :destroy
end
