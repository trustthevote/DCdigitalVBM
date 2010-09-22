Given /^the following users$/ do |table|
  table.hashes.each do |attributes|
    User.create!(attributes)
  end
end
