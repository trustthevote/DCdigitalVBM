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
  :state             => "DC",
  :attestation       => File.open("#{Rails.root}/db/fixtures/attestation.pdf", "rb"))