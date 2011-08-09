# == Schema Information
# Schema version: 20100712040454
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
  has_many :wikisessions
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :username, :password, :password_confirmation, :remember_me

  validates :username, :presence => true, :length => {:minimum => 2}, :uniqueness => true, :format => { :with => /[A-Za-z0-9_\.\-]+/ } 
  
  def self.included(base)
    base.extend ClassMethods
    assert_validations_api!(base)

    base.class_eval do
      validates_presence_of   :username
      validates_uniqueness_of :username, :scope => authentication_keys[1..-1], :case_sensitive => false, :allow_blank => true

      with_options :if => :password_required? do |v|
        v.validates_presence_of     :password
        v.validates_confirmation_of :password
        v.validates_length_of       :password, :within => password_length, :allow_blank => true
      end
    end
  end
end
