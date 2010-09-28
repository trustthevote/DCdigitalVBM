Then /^I should see (\d+) rows with voters in the table$/ do |n|
  page.should have_css("#voters tbody tr", :count => n.to_i)
end

Then /^I should see (\d+) statuses "([^"]*)"$/ do |n, status|
  page.should have_css('#voters td', :text => "Unconfirmed", :count => n.to_i)
end
