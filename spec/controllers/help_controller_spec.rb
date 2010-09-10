require 'spec_helper'

describe HelpController do

  describe "when sanitizing" do
    it "should remove everything by letters, digits and dashes" do
      @controller.send(:sanitize, "abc-d01_test/../test").should == "abc-d01testtest"
    end
  end

end
