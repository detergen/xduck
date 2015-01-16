class Product < ActiveRecord::Base
  #resourcify
#  attr_accessible :active, :articul, :forsale, :name, :note

  belongs_to :purchase_currency, :class_name => "Currency", :foreign_key => "purchase_currency_id"
  belongs_to :sale_currency, :class_name => "Currency", :foreign_key => "sale_currency_id"

  validates :name, :articul, :presence => true
  validates :articul, :uniqueness => true

  has_many :boms, :dependent => :delete_all


  def get_sale_price
    unless sale_price
      return 0
      #return boms.map { |b| b.qty * b.subproduct.get_sale_price }.sum
    end
    sale_price
  end

end
