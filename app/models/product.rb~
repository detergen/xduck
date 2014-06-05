class Product < ActiveRecord::Base
  resourcify
  attr_accessible :active, :articul, :forsale, :name, :note

  validates :name, :articul, :presence => true
  validates :name, :articul, :uniqueness => true

  has_many :boms, :dependent => :delete_all

end
