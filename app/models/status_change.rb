class StatusChange < ActiveRecord::Base

  belongs_to :registration
  belongs_to :reviewer, :class_name => "User"

  validates_inclusion_of :status, :in => %w( confirmed denied ), :allow_nil => true
  validates_presence_of  :reviewer_id, :registration_id

  def printable_status
    self.status ? self.status.capitalize : "Unconfirmed"
  end
  
end
