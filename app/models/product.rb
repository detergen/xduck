class Product < ActiveRecord::Base

  MEASURES = %w(м шт компл мешки коробка палета куб.м. кв.м кг т)

  belongs_to :purchase_currency, :class_name => "Currency", :foreign_key => "purchase_currency_id"
  belongs_to :sale_currency, :class_name => "Currency", :foreign_key => "sale_currency_id"

  validates :name, :articul, :presence => true
  validates :articul, :uniqueness => true
  validates :measure, :inclusion => MEASURES
  validates_length_of :name, maximum: 255, minimum: 0
  validates_length_of :articul, maximum: 255, minimum: 0
  
  has_many :boms, :dependent => :delete_all
  has_many :activity_items
  has_many :activities, through: :activity_items

  def get_sale_price
    unless sale_price
      return 0
      #return boms.map { |b| b.qty * b.subproduct.get_sale_price }.sum
    end
    sale_price
  end

end
