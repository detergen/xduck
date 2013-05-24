require 'spec_helper'

describe Product do

  it "has a valid factory" do
	FactoryGirl.create(:product)
  end

  it "is invalid without a name" do
	  FactoryGirl.build(:product, name: nil).should_not be_valid
  end

  it "is invalid without an articul" do
	  FactoryGirl.build(:product, articul: nil).should_not be_valid
  end

  it "is invalid without uniq articul" do
	  FactoryGirl.create(:product, name: "table", articul: "78555stol")
	  FactoryGirl.build(:product, name: "table1", articul: "78555stol").should_not be_valid
  end

  it "is invalid without uniq name" do
	  FactoryGirl.create(:product, name: "table", articul: "78555stol")
	  FactoryGirl.build(:product, name: "table", articul: "7855stol").should_not be_valid
  end

end
