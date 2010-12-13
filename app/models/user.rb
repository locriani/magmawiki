class User < ActiveRecord::Base
  has_many :authentications
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :username, :password, :password_confirmation, :remember_me
  attr_accessor :login
  attr_accessible :login

  def apply_omniauth(omniauth)  
    authentications.build(:provider => omniauth['provider'],:uid => omniauth['uid'])  
  end  
  
  def password_required?  
    (authentications.empty? || !password.blank?) && super  
  end  
  
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
  
  protected

  def self.find_for_database_authentication(conditions)
    value = conditions[authentication_keys.first]
    where(["username = :value", { :value => value }]).first
  end
end
