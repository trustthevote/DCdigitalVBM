# Version: OSDV Public License 1.2
# The contents of this file are subject to the OSDV Public License
# Version 1.2 (the "License"); you may not use this file except in
# compliance with the License. You may obtain a copy of the License at
# http://www.osdv.org/license/
# Software distributed under the License is distributed on an "AS IS"
# basis, WITHOUT WARRANTY OF ANY KIND, either express or implied.
# See the License for the specific language governing rights and limitations
# under the License.
# 
# The Original Code is:
# 	TTV UOCAVA Ballot Portal.
# The Initial Developer of the Original Code is:
# 	Open Source Digital Voting Foundation.
# Portions created by Open Source Digital Voting Foundation are Copyright (C) 2010.
# All Rights Reserved.
# 
# Contributors: Paul Stenbjorn, Aleksey Gureiev, Robin Bahr,
# Thomas Gaskin, Sean Durham, John Sebes.

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

Then /^I should see the page$/ do
  puts page.body
  pending
end
