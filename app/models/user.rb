class User < ActiveRecord::Base
  has_and_belongs_to_many :roles
  rolify
  #attr_accessible :email, :password, :roles, :role_ids
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, #:registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
