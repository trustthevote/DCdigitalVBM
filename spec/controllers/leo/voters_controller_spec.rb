require 'spec_helper'

describe Leo::VotersController do

  context ".voter_to_review" do
    before do
      @r1 = Factory(:registration, :status => "unconfirmed", :name => "Mark")
      @r2 = Factory(:registration, :status => "confirmed",   :name => "Jack")
    end
    
    it "should return the first reviewable registration if ID isn't given" do
      @controller.send(:voter_to_review, nil).should == @r1
    end
    
    it "should return the first reviewable registration if there's no such ID" do
      @controller.send(:voter_to_review, -1).should == @r1
    end
    
    it "should return the registration by ID" do
      @controller.send(:voter_to_review, @r1).should == @r1
    end
  end
  
end
