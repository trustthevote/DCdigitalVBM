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

puts "Cleaning the database"
Precinct.destroy_all

puts "Importing seed data"
path = File.expand_path(File.join(File.dirname(__FILE__), 'fixtures'))

di = DataImport.new
di.run("#{path}/AddressID.csv", "#{path}/RegSchema.csv")

# -----------------------------------------------------------------------------
# Sample record with ballot and attestation for testing
# -----------------------------------------------------------------------------

# Create a precinct
precinct = Precinct.create!(:name => "Test Precinct")

# Create a split
split = precinct.splits.create(:name => "Test Split")

# Create a split ballot style
ballot_style = split.create_ballot_style(:pdf => File.open("#{Rails.root}/db/fixtures/blank_ballot.pdf", "rb"))

# Create a registration
Registration.create!(
  :precinct_split_id => split.id,
  :name              => 'Mike',
  :pin               => '1234',
  :zip               => '24001',
  :voter_id          => '1234',
  :address           => "142 N Street",
  :city              => "Washington",
  :state             => "DC")