# Create a precinct
Precinct.destroy_all
precinct = Precinct.create!(:name => "Test Precinct")

# Create a split
PrecinctSplit.destroy_all
split = precinct.splits.create(:name => "Test Split")

# Create a split ballot style
BallotStyle.destroy_all
ballot_style = split.create_ballot_style(:pdf => File.open("#{Rails.root}/db/fixtures/blank_ballot.pdf", "rb"))

# Create a registration
Registration.destroy_all
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
