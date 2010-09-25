Then /^button "([^"]*)" should be enabled$/ do |label|
  page.should have_css("a.button", :text => label)
  page.should have_no_css("a.button.disabled", :text => label)
end

Then /^button "([^"]*)" should be disabled$/ do |label|
  page.should have_css("a.button.disabled", :text => label)
end

Then /^navigation buttons should be disabled$/ do
  Then %{button "Next" should be disabled}
  Then %{button "Previous" should be disabled}
end
