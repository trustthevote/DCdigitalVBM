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

describe PagesController do

  shared_examples_for "pages with blocked digital flow" do
    it "should redirect to the front page when requested with blocked digital flow" do
      @controller.stubs(:digital_enabled?).returns(false)
      @controller.stubs(:voting_type).returns("digital")
      get action
      response.should redirect_to(front_url)
    end
  end
  
  
  it "should display the front page" do
    get :front
    response.should render_template(:front)
  end

  context "when not voting" do
    it "should redirect to front page" do
      before_voting_started
      get :overview
      response.should redirect_to(front_url)
    end
  end
  
  context "when going to overview page" do
    it "should just show whatever it is" do
      get :overview
      response.should render_template(:overview)
    end

    it "should switch to digital" do
      get :overview, :voting_type => "digital"
      response.should render_template(:overview)
      @controller.voting_type.should == "digital"
    end
    
    it "should switch to physical" do
      get :overview, :voting_type => "physical"
      response.should render_template(:overview)
      @controller.voting_type.should == "physical"
    end
    
    it "should diallow digital flow if it's disabled" do
      @controller.stubs(:digital_enabled?).returns(false)
      get :overview, :voting_type => "digital"
      response.should redirect_to(front_url)
    end
  end
  
  context "when checking in" do
    let(:action) { :check_in }
    it_should_behave_like "pages with blocked digital flow"
    
    it "should display form" do
      get :check_in
      response.should render_template(:check_in)
    end
    
    it "should return to the check in form if record wasn't found" do
      post :check_in, :registration => { :pin => "unknown" }
      response.should render_template(:check_in)
      assigns(:registration).should be_nil
    end
    
    it "should move on to the confirm page when record was found" do
      r = Factory(:registration, :pin => "1234")
      post :check_in, :registration => { :pin => "1234", :name => r.name, :zip => r.zip, :voter_id => r.voter_id }
      response.should redirect_to(confirm_url)
    end
  end

  context "when requesting attestation PDF" do
    it "should redirect to check-in if haven't checked in yet" do
      get :attestation, :format => 'pdf'
      response.should redirect_to(check_in_url)
    end
    
    it "should render the PDF if checked in" do
      stub_registration
      get :attestation, :format => 'pdf'
      response.should render_template(:attestation)
    end
  end
  
  context "when confirming" do
    let(:action) { :confirm }
    it_should_behave_like "pages with blocked digital flow"

    before do
      stub_registration
    end
    
    it "should render the page" do
      get :confirm
      response.should render_template(:confirm)
    end

    it "should render the thanks page with the ballot receipt info if already uploaded" do
      Registration.any_instance.expects(:voted_digitally?).returns(true)
      get :confirm
      response.should redirect_to(thanks_url)
    end
  end

  context "when completing" do
    let(:action) { :complete }
    it_should_behave_like "pages with blocked digital flow"

    it "should render the page" do
      stub_registration
      Registration.any_instance.expects(:register_check_in!)
      get :complete
      response.should render_template(:complete)
    end
  end
  
  context "when sending ballot" do
    let(:action) { :return }
    it_should_behave_like "pages with blocked digital flow"

    before do
      stub_registration
    end

    it "should return to the same form if ballot is invalid and can't be saved" do
      @controller.stubs(:save_ballot).returns(false)
      post :return
      response.should render_template(:return)
    end
    
    it "should render the thanks page if all is good" do
      @controller.stubs(:save_ballot).returns(true)
      post :return
      response.should redirect_to(thanks_url)
    end
  end

  context "when viewing thanks" do
    let(:action) { :thanks }
    it_should_behave_like "pages with blocked digital flow"

    before do
      stub_registration
    end

    it "should render the page" do
      get :thanks
      response.should render_template(:thanks)
    end
    
    it "should register the completion" do
      Registration.any_instance.expects(:register_flow_completion!).with('digital')
      get :thanks
    end
  end

  context "when viewing supplementary pages" do
    context "and currently before the voting started" do
      before do
        before_voting_started
      end
      
      %w{ about contact }.each do |page|
        it "should render #{page} page" do
          get page.to_sym
          response.should render_template(page)
        end
      end
      
    end
  end

  def stub_registration
    @r = Factory(:registration)
    session[:voting_type] = 'digital'
    session[:rid] = @r.id
  end
end
