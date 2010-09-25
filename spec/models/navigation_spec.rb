require 'spec_helper'

describe Navigation do

  context "when empty" do
    it { should_not have_next }
    it { should_not have_previous }
  end

  context "when initialized with constants" do
    subject { Navigation.new(:previous => 'previous', :next => 'next') }
    it { should have_next }
    it { should have_previous }
    its(:next_item) { should == 'next' }
    its(:previous_item) { should == 'previous' }
  end

  context "when initialized with lambdas" do
    subject { Navigation.new(:previous => lambda { 'eval-previous' }, :next => lambda { 'eval-next' }) }
    its(:next_item) { should == 'eval-next' }
    its(:previous_item) { should == 'eval-previous' }
  end
  
end