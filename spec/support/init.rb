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

def before_voting_started
  @controller.stubs(:before_voting? => true, :after_voting? => false, :during_voting? => false)
end

def login_as(u = Factory(:user))
  @controller.stubs(:current_user).returns(u)
end
alias :login :login_as


# GET in LEO subdomain  
def leo_get(action, options = {})
  get action, { :subdomains => [ 'leo' ] }.merge(options)
end

# POST in LEO subdomain
def leo_post(action, options = {})
  post action, { :subdomains => [ 'leo' ] }.merge(options)
end
