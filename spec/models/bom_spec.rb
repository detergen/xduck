require 'spec_helper'

describe Bom do

		DatabaseCleaner.clean

  it "has a valid factory" do
	#create(:product)
	#create(:product)
	create(:bom)
	create(:bom)

	b =  Bom.find(:all)

	b.each do |b|
		print b.product_id.to_s+"->"+b.subproduct_id.to_s+"\n"
	end


	p = Product.find(:all)

	p.each do |prod|
		print prod.name+"\n"
	end

  end

  #it "is invalid without a name" do
	  #FactoryGirl.build(:bom, name: nil).should_not be_valid
  #end

  #it "is invalid without an articul" do
	  #FactoryGirl.build(:bom, articul: nil).should_not be_valid
  #end

  #it "is invalid without uniq articul" do
	  #FactoryGirl.create(:bom, name: "table", articul: "78555stol")
	  #FactoryGirl.build(:bom, name: "table1", articul: "78555stol").should_not be_valid
  #end

  #it "is invalid without uniq name" do
	  #FactoryGirl.create(:bom, name: "table", articul: "78555stol")
	  #FactoryGirl.build(:bom, name: "table", articul: "855stol").should_not be_valid
  #end

end
