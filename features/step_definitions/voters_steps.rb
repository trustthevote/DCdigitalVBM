Given /^no voters to review$/ do
  Registration.destroy_all
end

Given /^the following voters$/ do |table|
  table.hashes.each do |attributes|
    Factory(:registration, attributes)
  end
end

Given /^voter with name "([^"]*)" who hasn't voted yet$/ do |name|
  @voter = Factory(:voter, :name => name, :voted_digitally => false)
end

Given /^voter with name "([^"]*)" who voted digitally$/ do |name|
  @voter = Factory(:voter, :name => name)
end

When /^I set deny reason to "([^"]*)"$/ do |deny_reason|
  When %{I fill in "registration[deny_reason]" with "#{deny_reason}"}
end
