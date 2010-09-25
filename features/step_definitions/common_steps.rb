Given /^the following users$/ do |table|
  table.hashes.each do |attributes|
    User.create!(attributes)
  end
end

Given /^that I logged in$/ do
  u = User.create!(
    :login                 => 'user', 
    :email                 => 'user@osdv.org', 
    :password              => 'test', 
    :password_confirmation => 'test')

  visit   login_url
  fill_in "Login",    :with => u.login
  fill_in "Password", :with => u.password
  click_button "Login"
end
