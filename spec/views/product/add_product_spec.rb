require 'spec_helper'

describe "Products" do
	describe "Manage products" do

		it "Adds a new product and displays the results" do
			visit products_url
			expect{
				click_link 'New'
				fill_in 'Name', with: "Table"
				fill_in 'Articul', with: "tbl1"
				check 'Forsale'
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


		it "Delete a product" do
		product = create(:product)
		product = create(:product)
		product = create(:product)
			visit products_path
			#print page.html
		    expect{
			find(:xpath, "//tr[contains(.,'brl3')]/td/a", :text => 'Delete').click
			      }.to change(Product,:count).by(-1)
			page.should have_content "Products"
			page.should have_content "brl2"
			page.should_not have_content "brl3"
		end
	end
end
