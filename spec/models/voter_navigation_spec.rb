require 'spec_helper'

describe VoterNavigation do
  let(:voter) { Factory(:registration, :name => "Lee") }

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
      before { @ken = Factory(:registration, :name => "Ken") }
      it { should have_previous }
      it { should_not have_next }
      its(:previous_item) { should == @ken }
    end
    
    context "after current" do
      before { @mark = Factory(:registration, :name => "Mark") }
      it { should_not have_previous }
      it { should have_next }
      its(:next_item) { should == @mark }
    end
  end
end
