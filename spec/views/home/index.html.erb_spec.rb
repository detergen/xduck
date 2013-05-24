require 'spec_helper'

describe "home/index.html.erb" do
	it "Contain xDuck header" do
		visit root_path
		page.should have_content "XDuck"
	end
end
