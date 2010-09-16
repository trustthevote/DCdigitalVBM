require 'digest/sha1'

class Registration < ActiveRecord::Base

  belongs_to  :precinct_split
  has_one     :ballot, :dependent => :destroy
  has_many    :flow_completions

  validates_presence_of :pin_hash
  validates_presence_of :precinct_split_id

  named_scope :inactive,   :conditions => { :checked_in_at => nil }
  named_scope :checked_in, :conditions => "checked_in_at IS NOT NULL"
  named_scope :unfinished, :conditions => [ "checked_in_at IS NOT NULL AND last_completed_at IS NULL" ]
  
  def self.match(r)
    first(:conditions => {
      :name     => r[:name],
      :pin_hash => Registration.hash_pin(r[:pin]),
      :zip      => r[:zip],
      :voter_id => r[:voter_id] })
  end

  def pin=(v)
    self.pin_hash = Registration.hash_pin(v)
  end

  # Returns the blank ballot PDF
  def blank_ballot
    precinct_split.try(:ballot_style).try(:pdf)
  end

  def self.hash_pin(pin)
    return nil if pin.blank?
    Digest::SHA1.hexdigest(pin.gsub(/[^0-9A-Z]/i, ''))
  end

  # Returns TRUE if the ballot has already been uploaded
  def processed?
    !ballot.nil?
  end

  def processed_at
    ballot ? ballot.pdf_updated_at : Time.now
  end
  
  def register_flow_completion!(voting_type)
    self.update_attributes!(:last_completed_at => Time.now)
    self.flow_completions.find_or_create_by_voting_type(voting_type)
  end
  
  def register_check_in!
    self.checked_in_at = Time.now
    self.save!
  end
end
