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

describe Ballot do

  before do
    @s = Factory(:ballot_style)
    @r = Factory(:registration, :precinct_split_id => @s.precinct_split_id)
  end
  
  it "should reject the file with the name different from what was downloaded" do
   assert_validness({ :pdf_file_name => "weird.pdf" }, false, Ballot::ERROR_NAME)
  end
  
  it "should reject the file with the size less than half or more than 5 of original" do
    b = Factory.build(:ballot, :registration => @r)
    
    [ @s.pdf_file_size / 2 - 1, @s.pdf_file_size * 5 + 1 ].each do |size|
      b.stubs(:uploaded_pdf_size).returns(size)
      b.should_not be_valid
      b.errors[:base].should == Ballot::ERROR_SIZE
    end
  end
  
  it "should accept file with allowed sizes" do
    b = Factory.build(:ballot, :registration => @r)
    
    [ @s.pdf_file_size / 2, @s.pdf_file_size * 5 ].each do |size|
      b.stubs(:uploaded_pdf_size).returns(size)
      b.valid?
      (b.errors[:base] || []).should_not include(Ballot::ERROR_SIZE)
    end
  end

  it "should accept the file with the same name as downloaded ballot" do
    assert_validness(:pdf_file_name => @s.pdf.original_filename)
  end

  it "should accept the file with the suffixed name" do
    assert_validness(:pdf_file_name => ("%s-1.%s" % @s.pdf.original_filename.split('.')))
  end
  
  def assert_validness(ballot_options, valid = true, error = nil)
    b = Factory.build(:ballot, { :registration => @r }.merge(ballot_options))
    b.valid?.should == valid
    b.errors[:base].should == error unless valid
  end
end
