def voter_attestation_url(voter)
  leo_attestation_url(@voter, :protocol => 'https')
end

Then /^I should not see the attestation document link$/ do
  page.should have_no_xpath(%Q{//a[@href='#{voter_attestation_url(@voter)}']})
end

Then /^I should see the attestation document link$/ do
  page.should have_xpath(%Q{//a[@href='#{voter_attestation_url(@voter)}']})
end
