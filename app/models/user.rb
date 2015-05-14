class User < ActiveRecord::Base
  has_and_belongs_to_many :roles
  has_and_belongs_to_many :organizations
  rolify
  #attr_accessible :email, :password, :roles, :role_ids
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, # :ldap_authenticatable, #:registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def to_s
    email
  end

end
