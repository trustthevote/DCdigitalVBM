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
    let(:registration) { Factory(:registration) }

    it_should_behave_like "pages with blocked digital flow"
    
    context "and entering the page" do
      before  { get :check_in }
      it      { should render_template :check_in }
    end
    
    context "and submitting an invalid record" do
      before  { post :check_in, :registration => { :pin => "unknown" } }
      it      { should render_template :check_in }
      specify { assigns(:registration).should_not be }
    end
    
    context "and submitting a valid record" do
      before  { post :check_in, :registration => { :pin => '1111', :last_name => registration.last_name, :zip => registration.zip, :voter_id => registration.voter_id } }
      it      { should redirect_to confirm_url }
    end
  end

  context "when confirming" do
    let(:action) { :confirm }

    it_should_behave_like "pages with blocked digital flow"

    before { stub_registration }
    
    context "and just entering the page" do
      specify { get(:confirm).should render_template :confirm }
      specify { @controller.expects(:register).with(Activity::CheckIn).during get(:confirm) }
    end

    context "when already uploaded ballot" do
      before  { Registration.any_instance.expects(:voted_digitally?).returns(true) && get(:confirm) }
      it      { should redirect_to thanks_url }
    end
  end


  context "when requesting attestation PDF" do
    context "without having checked in" do
      before  { get :attestation, :format => 'pdf' }
      it      { should redirect_to check_in_url }
    end
    
    context "when checked in properly" do
      before  { stub_registration }
      specify { requesting_attestation.should render_template :attestation }
      specify { @controller.expects(:register).with(Activity::Download, :resource => "attestation").during requesting_attestation }
      def requesting_attestation; get(:attestation, :format => 'pdf'); end
    end
  end
  
  
  context "when requesting blank ballot" do
    context "without having checked in" do
      before  { get :ballot, :format => 'pdf' }
      it      { should redirect_to check_in_url }
    end
    
    context "when checked in properly" do
      before  { stub_registration && Registration.any_instance.stubs(:blank_ballot).returns(stub(:url => "http://somewhere.com/ballot.pdf")) }
      specify { requesting_ballot.should redirect_to @r.blank_ballot.url }
      specify { @controller.expects(:register).with(Activity::Download, :resource => "ballot").during requesting_ballot }
      def requesting_ballot; get(:ballot, :format => 'pdf'); end
    end
  end
  
  
  context "when completing" do
    let(:action) { :complete }
    it_should_behave_like "pages with blocked digital flow"

    before  { stub_registration }
    specify { get(:complete).should render_template :complete }
    specify { Registration.any_instance.expects(:register_check_in!).during get(:complete) }
    specify { @controller.expects(:register).with(Activity::Confirmation).during get(:complete) }
  end
  
  context "when sending ballot" do
    let(:action) { :return }
    it_should_behave_like "pages with blocked digital flow"

    before { stub_registration }

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

    before { stub_registration }

    specify { get(:thanks).should render_template :thanks }
    specify { Registration.any_instance.expects(:register_completion!).during get(:thanks) }
    specify { @controller.expects(:register).with(Activity::Completion).during get(:thanks) }
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
