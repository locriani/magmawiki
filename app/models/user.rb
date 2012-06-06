class User < ActiveRecord::Base
  authenticates_with_sorcery!
  
  attr_accessible :email, :username, :password, :password_confirmation

  validates :username, presence: true, uniqueness: true
  validates :password, confirmation: true
end
