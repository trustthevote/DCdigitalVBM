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

require 'spec_helper'

describe Registration do

  it "should return the empty ballot PDF" do
    b = Factory(:ballot_style)
    r = Factory(:registration, :precinct_split_id => b.precinct_split_id)
    
    r.blank_ballot.url.should == b.pdf.url
  end

  it "should calculate the correct PIN hash" do
    pin_hash = Digest::SHA1.hexdigest("1234567A12345678")
    Registration.hash_pin("1234567A12345678").should     == pin_hash
    Registration.hash_pin("1234-567A-1234-5678").should  == pin_hash
    Registration.hash_pin("1234 567A 1234 5678").should  == pin_hash
    Registration.hash_pin(" 1234567A 12345678 ").should  == pin_hash
    Registration.hash_pin("1234567a12345678").should     == pin_hash

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

  describe "processed flag and date" do
    it "should be processed when the ballot is uploaded" do
      s = Factory(:ballot_style)
      r = Factory(:registration, :precinct_split => s.precinct_split)
      b = Factory(:ballot, :registration => r)
      b.registration.should be_processed
      b.registration.processed_at.to_s.should == b.pdf_updated_at.to_s
    end
    
    it "should be unprocessed when there's no uploaded ballot" do
      r = Factory(:registration)
      r.should_not be_processed
      r.processed_at.to_s.should == Time.now.to_s
    end
  end
  
  describe "when registering flow completion" do
    it "should register the completion" do
      r = Factory(:registration)

      r.register_flow_completion!('digital')
      fcs = r.flow_completions
      fcs.size.should == 1
      fcs.first.voting_type.should == 'digital'
      r.last_completed_at.should_not be_nil
    end
    
    it "should register the completion of another type too" do
      fc = Factory(:flow_completion, :voting_type => 'physical')
      r  = fc.registration
      r.register_flow_completion!('digital')
      fcs = r.flow_completions
      fcs.size.should == 2
      fcs.last.voting_type.should == 'digital'
    end
    
    it "should not register the same voting type again" do
      fc = Factory(:flow_completion, :voting_type => 'physical')
      r = fc.registration
      r.register_flow_completion!('physical')
      r.flow_completions.size.should == 1
    end
  end
  
  describe "when registering a check in" do
    it "should set the time" do
      Timecop.freeze do
        r = Factory(:registration)
        r.register_check_in!
      
        r.reload
        r.checked_in_at.should == Time.now
      end
    end
  end
end
