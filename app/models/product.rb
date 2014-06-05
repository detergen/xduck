class Product < ActiveRecord::Base
<<<<<<< HEAD
  resourcify
  #attr_accessible :active, :articul, :forsale, :name, :note
=======
  attr_accessible :active, :articul, :forsale, :name, :note
>>>>>>> 1200571a19aad4a8b8271d24fdce6e7a0dc09450

  validates :name, :articul, :presence => true
  validates :name, :articul, :uniqueness => true

  has_many :boms, :dependent => :delete_all

end
