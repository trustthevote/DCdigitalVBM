require 'rubygems'
require 'faster_csv'
require 'faker'
require 'digest/sha1'

RECORDS_PER_ADDRESS = 400
UNIT_START          = 100
MIDDLE_NAMES        = ('A' .. 'Z').to_a
NULL_PROBABILITY    = 10

addresses = [ 
  [ '100 / %s LYTTON AVE, WASHINGTON DC 20009',   20009, "22 00",  "1B04" ],
  [ '200 / %s HOMER ST, WASHINGTON DC 20001',     20001, "129 00", "2C03" ],
  [ '300 / %s COWPER ST, WASHINGTON DC 20007',    20007, "11 00",  "3B05" ],
  [ '400 / %s BYRON ST, WASHINGTON DC 20015',     20015, "52 00",  "3G03" ],
  [ '500 / %s ADDISON AVE, WASHINGTON DC 20018',  20018, "69 00",  "5A11" ],
  [ '600 / %s KINGSLEY ST, WASHINGTON DC 20002',  20002, "84 00",  "6C06" ],
  [ '700 / %s SENECA AVE, WASHINGTON DC 20019',   20019, "95 00",  "7C06" ],
  [ '800 / %s HALE AVE, WASHINGTON DC 20032',     20032, "122 00", "8C03" ] ]

def null
  rand(NULL_PROBABILITY) == 0 ? 'NULL' : nil
end

voters_csv = lookup_csv = nil
lookup_csv = FasterCSV.generate(:col_sep => "\t") do |lookup|
  voters_csv = FasterCSV.generate(:col_sep => "\t") do |csv|
    lookup << [ 'VOTER_ID', 'PIN', 'LASTNAME', 'ZIP' ]
    csv    << [ 'VOTER_ID', 'PIN_HASH', 'LASTNAME', 'FIRSTNAME', 'MIDDLE', 'SSN', 'MAILINGADDRESS', 'ZIP', 'SMD', 'SPLIT' ]
    addresses.each do |mailingaddress_t, zip, split, smd|
      RECORDS_PER_ADDRESS.times do |i|
        mailingaddress = mailingaddress_t % (UNIT_START + i)
        voter_id       = rand(1000000000).to_s.rjust(9, '0')
        ssn            = null || rand(10000).to_s.rjust(8, '0')
        middle_name    = null || MIDDLE_NAMES.rand
        first_name     = Faker::Name.first_name
        last_name      = Faker::Name.last_name
        pin            = Digest::SHA1.hexdigest(mailingaddress + last_name)[0, 16].upcase
        pin_hash       = Digest::SHA1.hexdigest(pin)
      
        lookup << [ voter_id, pin, last_name, zip ]
        csv    << [ voter_id, pin_hash, last_name, first_name, middle_name, ssn, mailingaddress, zip, smd, split ]
      end
    end
  end
end

File.open('voters.csv', 'w') { |f| f.write(voters_csv) }
File.open('voters-lookup.csv', 'w') { |f| f.write(lookup_csv) }
