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
  pending # express the regexp above with the code you wish you had
end

Then /^I should see denial history record$/ do
  pending # express the regexp above with the code you wish you had
end
