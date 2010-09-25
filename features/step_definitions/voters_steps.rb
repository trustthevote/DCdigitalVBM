Given /^no voters to review$/ do
  Registration.destroy_all
end

Given /^the following voters$/ do |table|
  table.hashes.each do |attributes|
    Factory(:registration, attributes)
  end
end
