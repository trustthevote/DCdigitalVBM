class PrecinctSplit < ActiveRecord::Base
  
  belongs_to  :precinct
  has_one     :ballot_style
  has_many    :registrations
  
  validates   :precinct_id, :presence => true

end
