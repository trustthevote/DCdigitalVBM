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

def voter_attestation_url(voter)
  leo_attestation_url(@voter, :protocol => 'https')
end

Then /^I should not see the attestation document link$/ do
  page.should have_no_xpath(%Q{//a[@href='#{voter_attestation_url(@voter)}']})
end

Then /^I should see the attestation document link$/ do
  page.should have_xpath(%Q{//a[@href='#{voter_attestation_url(@voter)}']})
end

Then /^I should see voter address$/ do
  Then %{I should see "#{@voter.address}"}
  Then %{I should see "#{@voter.city}"}
  Then %{I should see "#{@voter.state}"}
  Then %{I should see "#{@voter.zip}"}
end

Then /^I should see voter status$/ do
  status = @voter.voted_digitally? ? "Voted" : "Not yet voted"
  Then %{I should see "#{status}"}
end

Then /^I should see the review status "([^"]*)"$/ do |status|
  Then %{I should see "#{status}"}
end

Then /^I should not see status manipulation buttons$/ do
  page.find("#review_controls").should_not be_visible
end

Then /^I should see the "([^"]*)" button$/ do |label|
  page.should have_css('a.button', :text => label)
end

Then /^I should see confirmation history record$/ do
  with_scope("#history") do
    page.should have_content("History")
    page.should have_content("Confirmed")
    page.should have_content(@user.login)
  end
end
