require 'spec_helper'

describe Registration do
  before(:each) do
    @valid_attributes = {
      :name => "value for name",
      :pin => "value for pin"
    }
  end

  it "should create a new instance given valid attributes" do
    Registration.create!(@valid_attributes)
  end
end
