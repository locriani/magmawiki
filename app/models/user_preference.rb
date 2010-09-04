# == Schema Information
# Schema version: 20100712040454
#
# Table name: user_preferences
#
#  id         :integer         not null, primary key
#  preference :string(255)     
#  value      :string(255)     
#  user_id    :integer         
#  created_at :datetime        
#  updated_at :datetime        
#

class UserPreference < ActiveRecord::Base
  belongs_to :user
end
