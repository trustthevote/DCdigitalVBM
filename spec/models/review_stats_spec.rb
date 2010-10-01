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

describe ReviewStats do
  
  before do
    4.times { Factory(:registration) }
    3.times { Factory(:voter) } # Unreviewed
    2.times { Factory(:reviewed_voter) } # Reviewed / confirmed
    1.times { Factory(:reviewed_voter, :status => "denied") }
  end
  
  its(:total)       { should == 4 + 3 + 2 + 1 }
  its(:returned)    { should == 3 + 2 + 1 }
  its(:reviewed)    { should == 2 + 1 }
  its(:confirmed)   { should == 2 }
  its(:denied)      { should == 1 }

end
