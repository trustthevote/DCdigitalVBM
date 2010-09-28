require 'spec_helper'

describe ReviewStats do
  
  before do
    5.times { Factory(:registration) }
    4.times { Factory(:voter) } # Unreviewed
    3.times { Factory(:reviewed_voter) } # Reviewed / unconfirmed
    2.times { Factory(:reviewed_voter, :status => "confirmed") }
    1.times { Factory(:reviewed_voter, :status => "denied") }
  end
  
  its(:total)       { should == 5 + 4 + 3 + 2 + 1 }
  its(:returned)    { should == 4 + 3 + 2 + 1 }
  its(:reviewed)    { should == 3 + 2 + 1 }
  its(:unconfirmed) { should == 3 }

end
