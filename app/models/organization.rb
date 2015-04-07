class Organization < ActiveRecord::Base
  # has_and_belongs_to_many :users, :join_table => :organizations_users
  has_many :users, through: :organizations_users
  has_many :organizations_users
  has_many :bankaccs
  has_many :contacts
  has_many :addrs

  def head_contact
    contacts.where(key: :head).first
  end

  def book_contact
    contacts.where(key: :book).first
  end

  def legal_address
    addrs.where(key: :law_address).first
  end

  def short_name_with_opf
    "#{opf} #{short_name}"
  end

end
