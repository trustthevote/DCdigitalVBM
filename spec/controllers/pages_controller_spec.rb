require 'spec_helper'

describe PagesController do

  it "should display the front page" do
    get :front
    response.should render_template(:front)
  end

  describe "when going to overview page" do
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
  end
  
  describe "when checking in" do
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
      r = Factory(:registration)
      post :check_in, :registration => { :pin => r.pin, :name => r.name }
      response.should redirect_to(confirm_url)
    end
  end
  
end
