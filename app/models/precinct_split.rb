class PrecinctSplit < ActiveRecord::Base
  
  belongs_to  :precinct
  has_one     :ballot_style, :dependent => :destroy
  has_many    :registrations, :dependent => :destroy
  
  validates_presence_of :precinct_id

end
