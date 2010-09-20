# Version: OSDV Public License 1.2
# "The contents of this file are subject to the OSDV Public License
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

describe Ballot do

  before do
    @s = Factory(:ballot_style)
    @r = Factory(:registration, :precinct_split_id => @s.precinct_split_id)
  end
  
  it "should accept the file with the same name as downloaded ballot" do
    b = Factory.build(:ballot, :registration => @r, :pdf_file_name => "weird.pdf")
    b.should_not be_valid
    b.errors[:base].should == Ballot::ERROR_NAME
  end
  
  it "should reject the file with the name different from what was downloaded" do
    b = Factory.build(:ballot, :registration => @r, :pdf_file_name => @s.pdf.original_filename)
    b.should be_valid
  end

  it "should reject the file with the name different from what was downloaded with suffix" do
    parts = @s.pdf.original_filename.split('.')
    b = Factory.build(:ballot, :registration => @r, :pdf_file_name => "#{parts[0]}-1.#{parts[1]}")
    b.should be_valid
  end

end
