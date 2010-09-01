require 'spec_helper'

describe Registration do

  it "should return the empty ballot PDF" do
    b = Factory(:ballot_style)
    r = Factory(:registration, :precinct_split_id => b.precinct_split_id)
    
    r.blank_ballot.url.should == b.pdf.url
  end

end
