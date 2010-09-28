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

describe Leo::VotersController do
  let(:voter) { Factory(:voter) }

  before { login }

  context "when reviewing a voter" do
    it "should look for voter" do
      @controller.expects(:voter_to_review).with(voter.to_param).returns(stub)
      get :show, :subdomains => [ 'leo' ], :id => voter.id
      response.should render_template(:show)
    end
  end

  context "when downloading attestation document" do
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

  context "when seeing the index of voters" do
    it "should return the list of voters" do
      20.times { Factory(:voter) }
      get :index, :subdomains => ['leo']

      vs = assigns(:voters)
      vs.should_not be_nil
      vs.size.should == Leo::VotersController::VOTERS_PER_PAGE
    end
    
    it "should be just unconfirmed voters by default" do
      Factory(:voter, :status => "confirmed")
      Factory(:voter, :status => "denied")
      unconfirmed = Factory(:voter)
      
      get :index, :subdomains => ['leo']
      
      vs = assigns(:voters)
      vs.should == [ unconfirmed ]
    end
  end
end
