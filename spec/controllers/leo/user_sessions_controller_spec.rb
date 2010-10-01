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
