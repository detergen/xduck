class Bankacc < ActiveRecord::Base
	belongs_to :organization

	scope :sorted, ->() { 'sort_order desc NULLs last' }
end
