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