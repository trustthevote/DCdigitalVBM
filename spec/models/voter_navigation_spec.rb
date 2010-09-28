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
  let(:voter) { Factory(:voter, :name => "Lee") }

  context "when no current voter given" do
    it { should_not have_next }
    it { should_not have_previous }
  end
    
  context "when no other voters" do
    subject { VoterNavigation.new(voter) }
    it { should_not have_next }
    it { should_not have_previous }
  end
  
  context "when there are other voters" do
    subject { VoterNavigation.new(voter) }

    context "before current" do
      before { @ken = Factory(:voter, :name => "Ken") }
      it { should have_previous }
      it { should_not have_next }
      its(:previous_item) { should == @ken }
    end
    
    context "after current" do
      before { @mark = Factory(:voter, :name => "Mark") }
      it { should_not have_previous }
      it { should have_next }
      its(:next_item) { should == @mark }
    end
  end
end
