require 'spec_helper'

describe Leo::VotersController do
  let(:voter) { Factory(:voter) }

  context "when reviewing a voter" do
    before { login }
    
    it "should look for voter" do
      @controller.expects(:voter_to_review).with(voter.to_param).returns(stub)
      get :show, :subdomains => [ 'leo' ], :id => voter.id
      response.should render_template(:show)
    end
  end

  context "when downloading attestation document" do
    before { login }
    
    it "should return attestation PDF for the known user" do
      get :attestation, :subdomains => [ 'leo' ], :id => voter.id, :format => 'pdf'
      response.should render_template('pages/attestation')
    end
    
    it "should return empty page for unknown user" do
      get :attestation, :subdomains => [ 'leo' ], :id => -1, :format => 'pdf'
      response.body.should be_blank
    end
  end
  
  context "when updating" do
    before { login }
  
    it "should find the voter by ID" do
      Registration.expects(:find).with('99').returns(stub(:update_status => nil))
      post :update, :subdomains => ['leo'], :id => 99
    end
    
    it "should update status" do
      Registration.expects(:find).returns(mock(:update_status => nil))
      post :update, :subdomains => ['leo'], :id => 99
    end
    
    it "should render show page with the updated voter" do
      post :update, :subdomains => ['leo'], :id => voter.id, :registration => { :status => "confirmed" }
      assigns(:voter).should == voter
      response.should render_template(:show)
    end

    it "should look for the first revieable voter if the specified isn't found" do
      Registration.expects(:reviewable).returns(mock(:first => voter))
      post :update, :subdomains => ['leo'], :id => -1
      assigns(:voter).should == voter
    end
  end
  
  context ".voter_to_review" do
    before do
      @r1 = Factory(:voter, :name => "Mark")
      @r2 = Factory(:voter, :name => "Jack", :status => "confirmed")
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
