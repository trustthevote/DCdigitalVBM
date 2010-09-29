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

describe VoterNavigation do
  let(:voter) { Factory(:voter) }
  let(:reviewed_voter) { Factory(:reviewed_voter) }

  context "when no voters" do
    it "should return nil" do
      subject.next.should be_nil
    end
  end
  
  context "no unreviewed voters" do
    it "should return nil" do
      Factory(:reviewed_voter)
      subject.next(reviewed_voter).should be_nil
    end
  end
  
  context "several unreviewed voters" do
    before do
      @a = Factory(:voter, :name => "A")
      @b = Factory(:reviewed_voter, :name => "B")
      @c = Factory(:voter, :name => "C")
    end
    
    it "should return A as first" do
      subject.next.should == @a
    end
    
    it "should return C for A and B" do
      subject.next(@a).should == @c
      subject.next(@b).should == @c
    end
    
    it "should return A for C" do
      subject.next(@c).should == @a
    end
  end

end
