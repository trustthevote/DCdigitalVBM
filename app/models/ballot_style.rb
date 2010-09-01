class BallotStyle < ActiveRecord::Base

  belongs_to :precinct_split
  
  has_attached_file :pdf, :path => ':rails_root/public/assets/ballot_styles/:filename',
                          :url  => '/assets/ballot_styles/:filename'

end
