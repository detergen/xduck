class Organization < ActiveRecord::Base
  # has_and_belongs_to_many :users, :join_table => :organizations_users
  has_many :users, through: :organizations_users
  has_many :organizations_users
  has_many :bankaccs
  has_many :contacts
  has_many :addrs

end
