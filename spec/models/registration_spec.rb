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
#		TTV UOCAVA Ballot Portal.
# The Initial Developer of the Original Code is:
#		Open Source Digital Voting Foundation.
# Portions created by Open Source Digital Voting Foundation are Copyright (C) 2010.
# All Rights Reserved.
# 
# Contributors: Paul Stenbjorn, Aleksey Gureiev, Robin Bahr,
# Thomas Gaskin, Sean Durham, John Sebes.

require 'spec_helper'

describe Registration do
	let(:r) { Factory(:registration) }
	let(:v) { Factory(:voter) }

  it { should have_many :activity_records }

	it "should return the empty ballot PDF" do
		b = Factory(:ballot_style)
		r = Factory(:registration, :precinct_split_id => b.precinct_split_id)
		
		r.blank_ballot.url.should == b.pdf.url
	end

	it "should calculate the correct PIN hash" do
		pin_hash = Digest::SHA1.hexdigest("1234567A12345678")
		Registration.hash_pin("1234567A12345678").should		 == pin_hash
		Registration.hash_pin("1234-567A-1234-5678").should	 == pin_hash
		Registration.hash_pin("1234 567A 1234 5678").should	 == pin_hash
		Registration.hash_pin(" 1234567A 12345678 ").should	 == pin_hash
		Registration.hash_pin("1234567a12345678").should		 == pin_hash

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
			r = Factory(:registration, :precinct_split => s.precinct_split, :voted_digitally => true)
			b = Factory(:ballot, :registration => r)
			b.registration.should be_voted_digitally
			b.registration.processed_at.to_s.should == b.pdf_updated_at.to_s
		end
		
		it "should be unprocessed when there's no uploaded ballot" do
			r = Factory(:registration)
			r.should_not be_voted_digitally
			r.processed_at.should be_nil
		end
	end
	
	describe "when registering completion" do
		it "should register the completion" do
		  Timecop.freeze do
  		  r = Factory(:registration)
  		  r.register_completion!
  		  
  		  r.reload
  		  r.completed_at.should == Time.now
		  end
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
	
	context "registering ballot" do
		it "should not set the voted_digitally flag if ballow is invalid" do
			r.expects(:build_ballot).returns(stub(:save => false))
			r.register_ballot!(stub)
			r.should_not be_voted_digitally
		end
		
		it "should set the voted_digitally flag if ballot is saved" do
			r.expects(:build_ballot).returns(stub(:save => true))
			r.register_ballot!(stub)
			r.should be_voted_digitally
		end
	end

	context ".reviewable scope" do
		it "should return only with returned ballots and sorted by status, then names" do
			Registration.destroy_all
			@r1 = Factory(:voter, :name => "Mark")
			@r2 = Factory(:voter, :name => "Lee") # Name goes before the first one
			@r3 = Factory(:registration, :name => "Beth") # Name goes before the first one
			@r4 = Factory(:reviewed_voter, :name => "Jack") # Name goes before the first two

			Registration.reviewable.map(&:id).should == [ @r2.id, @r1.id, @r4.id ]
		end
	end
	
	context ".update_status" do
		let(:user) { Factory(:user) }
		
		it "should set only status related fields and reviewer" do
			v.update_status({ :status => "denied", :deny_reason => "Some", :name => "updated" }, user).should be_true
			v.reload
			v.should be_denied
			v.deny_reason.should == "Some"
			v.last_reviewed_at.should_not be_nil
		end
		
		it "should unconfirm when status isn't set" do
		  v.update_status(nil, user)
		  v.reload.should be_unconfirmed
		end

		it "should return false if saving failed" do
			v.update_status({ :status => "unknown" }, user).should be_false
		end
		
		it "should not update the record if status is blank (skipping)" do
		  v.update_status({ :status => "", :deny_reason => "some" }, user)
		  v.reload
		  v.should be_unconfirmed
		  v.deny_reason.should be_nil
	  end
	  
    context "accepting ballots" do
      it "should accept the ballot when confirming" do
        v.stubs(:ballot).returns(mock(:accept! => true))
        v.update_status({ :status => "confirmed" }, user)
      end
      
      it "should not accept the ballot when denying or skipping" do
        ballot = Ballot.new
        ballot.stubs(:accept!).raises("Must not invoke")
        v.stubs(:ballot).returns(ballot)
        v.update_status({ :status => "denied" }, user)
        v.update_status({ :status => "" }, user)
      end
    end
    
	  context "creating log records" do
	    it "should create a record for confirming" do
	      v.update_status({ :status => "confirmed", :deny_reason => "reason" }, user)
	      v.should have_log_record("Confirmed", :reviewer => user)
      end

	    it "should create a record for denying" do
	      v.update_status({ :status => "denied", :deny_reason => "reason" }, user)
	      v.should have_log_record("Denied", :deny_reason => "reason", :reviewer => user)
      end
      
	    it "should create a record for skipping" do
	      v.update_status({ :status => "", :deny_reason => "reason" }, user)
	      v.should have_log_record("Skipped", :reviewer => user)
      end
    end
	end
	
	context ".reviewed?" do
		it "should report FALSE when status is other than Unconfirmed" do
			v.status = nil
			v.should_not be_reviewed
		end
		
		it "should report TRUE when Confirmed or Denied" do
			v.status = "confirmed"
			v.should be_reviewed

			v.status = "denied"
			v.should be_reviewed
		end
	end

  context "status named scopes" do
    before do
      @unchecked  = Factory(:registration)
      @unfinished = Factory(:registration, :checked_in_at => 2.minutes.ago)
      @finished   = Factory(:registration, :completed_at => 1.minute.ago)
    end
    
    it "should return correct records for .finished" do
      Registration.finished.should        == [ @finished ]
    end
    
    it "should return correct records for .checked_in" do
      Registration.checked_in.should      include @unfinished
      Registration.checked_in.should      include @finished
      Registration.checked_in.should_not  include @unchecked
    end
    
    it "should return correct records for .unfinished" do
      Registration.unfinished.should      == [ @unfinished ]
    end
    
    it "should return correct records for .inactive" do
      Registration.inactive.should        == [ @unchecked ]
    end
  end
end
