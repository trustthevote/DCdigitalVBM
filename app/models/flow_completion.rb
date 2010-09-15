class FlowCompletion < ActiveRecord::Base
  belongs_to :registration
  
  named_scope :digital, :conditions => { :voting_type => 'digital' }
  named_scope :physical, :conditions => { :voting_type => 'physical' }
  
end
