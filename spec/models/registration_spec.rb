require 'spec_helper'

describe Registration do

  it "should return the empty ballot PDF" do
    b = Factory(:ballot_style)
    r = Factory(:registration, :precinct_split_id => b.precinct_split_id)
    
    r.blank_ballot.url.should == b.pdf.url
  end

  it "should calculate the correct PIN hash" do
    pin_hash = Digest::SHA1.hexdigest("1234567812345678")
    Registration.hash_pin("1234567812345678").should     == pin_hash
    Registration.hash_pin("1234-5678-1234-5678").should  == pin_hash
    Registration.hash_pin("1234 5678 1234 5678").should  == pin_hash
    Registration.hash_pin(" 12345678 12345678 ").should  == pin_hash

    Registration.hash_pin(nil).should be_nil
    Registration.hash_pin(" ").should be_nil
  end
  
  describe "when matches" do
    it "should find the record that matches info" do
      pin = "1234567812345678"
      r = Factory(:registration, :pin => pin)
      Registration.match(:name => r.name, :zip => r.zip, :voter_id => r.voter_id, :pin => pin).should == r
    end
  
    it "should return nil if nothing was found" do
      Registration.match(:name => "Unknown", :zip => "24001", :voter_id => "1", :pin => "1").should be_nil
    end
  end
  
end
