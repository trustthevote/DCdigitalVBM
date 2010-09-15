Factory.sequence(:pin)  { |i| i.to_s.rjust(4, '0') }
Factory.sequence(:name) { |i| "name_#{i}" }

Factory.define :precinct do |f|
  f.name              { Factory.next(:name) }
end

Factory.define :precinct_split do |f|
  f.association       :precinct
  f.name              { Factory.next(:name) }
end

Factory.define :ballot_style do |f|
  f.association       :precinct_split
  f.pdf_file_name     "blank_ballot.pdf"
  f.pdf_content_type  "application/pdf"
  f.pdf_file_size     91574
  f.pdf_updated_at    { Time.now }
end

Factory.define :registration do |f|
  f.association       :precinct_split
  f.name              { Faker::Name.name }
  f.pin               { Factory.next(:pin) }
  f.zip               '34001'
  f.voter_id          { Factory.next(:pin) }
end

Factory.define :ballot do |f|
  f.association       :registration
  f.pdf_file_name     "blank_ballot.pdf"
  f.pdf_content_type  "application/pdf"
  f.pdf_file_size     91574
  f.pdf_updated_at    { Time.now }
end

Factory.define :flow_completion do |f|
  f.association       :registration
  f.voting_type       "physical"
end