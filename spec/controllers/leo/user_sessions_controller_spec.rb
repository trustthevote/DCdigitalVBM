require 'spec_helper'

describe Leo::UserSessionsController do
  let(:user) { Factory(:user) }
  
  context "logging" do
    it "should log sign ins" do
      post :create, :user_session => { :login => user.login, :password => user.password }
      user.should have_log_record("LoggedIn", :reviewer => user)
    end
    
    it "should log sign outs" do
      @controller.stubs(:current_user_session).returns(stub(:destroy => true, :record => user))
      post :destroy
      user.should have_log_record("LoggedOut", :reviewer => user)
    end
  end

end
