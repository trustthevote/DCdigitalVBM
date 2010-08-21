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
end
