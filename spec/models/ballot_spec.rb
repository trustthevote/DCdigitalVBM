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
