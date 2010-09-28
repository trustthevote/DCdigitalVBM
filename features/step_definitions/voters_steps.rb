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

Given /^confirmed voter with name "([^"]*)"$/ do |name|
  Given %{voter with name "#{name}" who voted digitally}
  @voter.update_status({ :status => "confirmed" }, @user)
end

Given /^there are (\d+) registrations$/ do |n|
  n.to_i.times { Factory(:registration) }
end

Given /^there are (\d+) ([^\s]+) voters$/ do |n, status|
  entity = (status == "unreviewed" ? :voter : :reviewed_voter)
  status = nil if %w(unconfirmed unreviewed).include?(status)
  n.to_i.times { Factory(entity, :status => status) }
end
