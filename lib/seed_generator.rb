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

class SeedGenerator
  CHARS_IN_PIN            = 16
  CHARS_IN_VOTER_ID       = 9
  FIRST_UNIT              = 1000
  REGISTRATIONS_PER_SPLIT = 400

  def run
    path = File.expand_path(File.join(File.dirname(__FILE__), '..', '..', 'db', 'seeds.rb'))
    File.open(path, "w") do |f|
      generate(f)
    end
  end
  
  private
  
  def generate(f)
    f.puts <<-EOF
puts "Destroying precincts, splits and registrations"
Precinct.destroy_all

puts "Generating new records..."

EOF

    addresses = [
      [ "100 Lytton Avenue",    "20001", "Ward 1", "Precinct 42",   "SMD-06-ANC-1A" ],
      [ "200 Homer Street",     "20002", "Ward 2", "Precinct 2",    "SMD-01-ANC-2A" ],
      [ "300 Cowper Street",    "20003", "Ward 3", "Precinct 8",    "SMD-04-ANC-3D" ],
      [ "400 Byron Street",     "20004", "Ward 4", "Precinct 45",   "SMD-07-ANC-4C" ],
      [ "500 Addison Avenue",   "20005", "Ward 5", "Precinct 66",   "SMD-01-ANC-5A" ],
      [ "600 Kingsley Street",  "20006", "Ward 6", "Precinct 142",  "SMD-01-ANC-6D" ],
      [ "700 Seneca Avenue",    "20007", "Ward 7", "Precinct 101",  "SMD-04-ANC-7D" ],
      [ "800 Hale Avenue",      "20008", "Ward 8", "Precinct 114",  "SMD-05-ANC-8A" ] ]
  
    addresses.each do |address, zip, ward, precinct_name, split_name|
      generate_precinct(f, precinct_name, split_name, address, zip)
    end
  end

  def generate_precinct(f, precinct_name, split_name, address, zip)
    f.puts <<-EOF
precinct      = Precinct.find_or_create_by_name('#{precinct_name}')
ballot_style  = nil
split         = precinct.splits.find_or_create_by_name(:name => '#{split_name}', :ballot_style => ballot_style)

puts
puts "#{'Name'.ljust(30, ' ')} #{'PIN'.ljust(CHARS_IN_PIN, ' ')} #{'Voter ID'.ljust(CHARS_IN_VOTER_ID, ' ')} ZIP"
EOF

    unit          = FIRST_UNIT

    REGISTRATIONS_PER_SPLIT.times do |n|
      name        = Faker::Name.name
      key         = "#{n}#{name}#{zip}#{Time.now.to_i}".gsub(/[^A-Z0-9]/i, '')
      pin         = Radix.convert(key, 62, 16)[0, CHARS_IN_PIN]
      vid         = Radix.convert(key, 62, 10)[0, CHARS_IN_VOTER_ID]

      f.puts <<-EOF
split.registrations.create(
  :name        => "#{name}",
  :pin         => '#{pin}',
  :voter_id    => '#{vid}', 
  :address     => "#{address}, Unit #{unit}",
  :city        => 'Washington',
  :state       => 'DC',
  :zip         => '#{zip}')
puts "#{name.ljust(30, ' ')} #{pin} #{vid} #{zip}"

EOF

      unit += 1
    end
  end
end