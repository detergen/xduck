require 'spec_helper'

describe "Products" do
  describe "Manage products" do

    it "Adds a new product and displays the results" do
      visit products_url
      expect{
        click_link 'New'
        fill_in 'Name', with: "Table"
        fill_in 'Articul', with: "tbl1"
        #fill_in 'Forsale', with: "True"
        fill_in 'Note', with: "This is very fine table with oaks and stainless steel."
        click_button "Create Product"
      }.to change(Product,:count).by(1)
      #page.should have_content "Contact was successfully created."
      within 'h1' do
        #page.should have_content "Table"
      end
      page.should have_content "Table"
      page.should have_content "tbl1"
    end

	it "Deletes a product" do
		product = FactoryGirl.create(:product, name: "Table", articul:"tbl1")
		product = FactoryGirl.create(:product, name: "Table2", articul:"tbl2")
		visit products_path
		expect{
			find(:xpath, "//tr[contains(.,'#{product.id}')]/td/a", :text => 'Delete').click
		}.to change(Product,:count).by(-1)
		page.should have_content "Products"
		page.should have_content "tbl1"
		page.should_not have_content "tbl2"
	end

  end
end
