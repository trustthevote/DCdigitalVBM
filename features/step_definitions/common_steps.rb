Given /^the following users$/ do |table|
  table.hashes.each do |attributes|
    User.create!(attributes)
  end
end

Given /^that I logged in$/ do
  @user = User.create!(
    :login                 => 'user', 
    :email                 => 'user@osdv.org', 
    :password              => 'test', 
    :password_confirmation => 'test')

  visit   login_url
  fill_in "Login",    :with => @user.login
  fill_in "Password", :with => @user.password
  click_button "Login"
end
