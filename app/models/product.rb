class Product < ActiveRecord::Base
  attr_accessible :active, :articul, :forsale, :name, :note

  has_many :boms
end
