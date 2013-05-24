Given(/^home page$/) do
  visit root_path
end

Then(/^page should have logo "(.*?)"$/) do |arg1|
  page.should have_content arg1
end

And (/^page should have Menu "(.*?)"$/) do |arg1|
  page.should have_content arg1
end

