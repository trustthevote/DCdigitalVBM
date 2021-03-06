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

MIDDLE_NAMES = ('A' .. 'Z').to_a

Factory.sequence(:vid)    { |i| i.to_s.rjust(9, '0') }
Factory.sequence(:name)   { |i| "name_#{i}" }
Factory.sequence(:login)  { |i| "login_#{i}" }

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
  f.first_name        { Faker::Name.first_name }
  f.middle_name       { MIDDLE_NAMES.rand }
  f.last_name         { Faker::Name.last_name }
  f.pin               '1111'
  f.address           '140 N Street, Washington DC 20001'
  f.zip               '20004'
  f.voter_id          { Factory.next(:vid) }
end


Factory.define :voter, :parent => :registration do |f|
  f.voted_digitally   true
end

Factory.define :reviewed_voter, :parent => :voter do |f|
  f.last_reviewed_at  { Time.now }
  f.reviewer          { @reviewer ||= Factory(:user) }
  f.status            "confirmed"
end

Factory.define :ballot do |f|
  f.association       :registration
  f.pdf_file_name     "blank_ballot.pdf"
  f.pdf_content_type  "application/pdf"
  f.pdf_file_size     91574
  f.uploaded_pdf_size 91574
  f.pdf_updated_at    { Time.now }
end

Factory.define :user do |f|
  f.login             { Factory.next(:login) }
  f.email             { |o| "#{o.login}@localhost.com" }
  f.password          "test"
  f.password_confirmation { |o| o.password }
end

Factory.define :activity, :class => Activity::Base do |f|
  f.association       :registration
  f.voting_type       'digital'
end

Factory.define :check_in, :class => Activity::CheckIn do |f|
  f.association       :registration
end

Factory.define :confirmation, :class => Activity::Confirmation do |f|
  f.association       :registration
end

Factory.define :completion, :class => Activity::Completion do |f|
  f.association       :registration
end

Factory.define :download, :class => Activity::Download do |f|
  f.association       :registration
end
