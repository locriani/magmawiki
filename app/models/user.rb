# == Schema Information
# Schema version: 20100513034408
#
# Table name: users
#
#  id                  :integer         not null, primary key
#  login               :string(255)     not null
#  email               :string(255)     not null
#  crypted_password    :string(255)     not null
#  password_salt       :string(255)     not null
#  persistence_token   :string(255)     not null
#  single_access_token :string(255)     not null
#  perishable_token    :string(255)     not null
#  login_count         :integer         default(0), not null
#  failed_login_count  :integer         default(0), not null
#  last_request_at     :datetime        
#  current_login_at    :datetime        
#  last_login_at       :datetime        
#  current_login_ip    :string(255)     
#  last_login_ip       :string(255)     
#  created_at          :datetime        
#  updated_at          :datetime        
#

class User < ActiveRecord::Base
  has_many :user_preferences
  attr_accessor :locale
  
  acts_as_authentic do |c|
    c.crypto_provider = Authlogic::CryptoProviders::BCrypt
  end
  
  # This allows us to use user.preferences as an accessor.
  def preferences
    @preferences ||= Preferences.new(self)
  end
end

# Shorcut class to allow us to use user.preferences[:key] format.
class Preferences
  def initialize(user)
    @user = user
  end
  
  def [](key)
    preference = @user.user_preferences.find_by_preference(key.to_s)
    preference.value unless preference.nil?
  end
  
  def []=(key, value)
    preference = @user.user_preferences.find_or_create_by_preference(key.to_s)
    preference.value = value
    preference.save!
  end
end
