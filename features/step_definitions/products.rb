# -*- encoding : utf-8 -*-
Given(/^I am on home page$/) do
  #visit products_path
  visit root_path
end

When(/^I push Browse products button$/) do
  #visit "/products"
	click_link "Browse Products"
end

Then(/^page should have header "(.*?)"$/) do |arg1|
  page.should have_content arg1
end

And (/^table should have in head "(.*?)"$/) do |arg1|
  page.should have_content arg1
end

And (/^page should have link "(.*?)"$/) do |name|
  find_link "New"
end

