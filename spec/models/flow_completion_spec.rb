require 'spec_helper'

describe FlowCompletion do
  before(:each) do
    @valid_attributes = {
      :registration_id => 1,
      :voting_type => "value for voting_type"
    }
  end

  it "should create a new instance given valid attributes" do
    FlowCompletion.create!(@valid_attributes)
  end
end
