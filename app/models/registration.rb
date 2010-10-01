# Version: OSDV Public License 1.2
# The contents of this file are subject to the OSDV Public License
# Version 1.2 (the "License"); you may not use this file except in
# compliance with the License. You may obtain a copy of the License at
# http://www.osdv.org/license/
# Software distributed under the License is distributed on an "AS IS"
# basis, WITHOUT WARRANTY OF ANY KIND, either express or implied.
# See the License for the specific language governing rights and limitations
# under the License.
# 
# The Original Code is:
# 	TTV UOCAVA Ballot Portal.
# The Initial Developer of the Original Code is:
# 	Open Source Digital Voting Foundation.
# Portions created by Open Source Digital Voting Foundation are Copyright (C) 2010.
# All Rights Reserved.
# 
# Contributors: Paul Stenbjorn, Aleksey Gureiev, Robin Bahr,
# Thomas Gaskin, Sean Durham, John Sebes.

require 'digest/sha1'

class Registration < ActiveRecord::Base

  belongs_to  :precinct_split
  has_one     :ballot, :dependent => :destroy
  has_many    :flow_completions, :dependent => :destroy
  belongs_to  :reviewer, :class_name => "User"
  has_many    :log_records, :class_name => "LogRecord::Base", :dependent => :destroy

  validates_presence_of :pin_hash
  validates_presence_of :precinct_split_id
  validates_inclusion_of :status, :in => %w( confirmed denied ), :allow_nil => true

  named_scope :inactive,    :conditions => { :checked_in_at => nil }
  named_scope :checked_in,  :conditions => "checked_in_at IS NOT NULL"
  named_scope :unfinished,  :conditions => [ "checked_in_at IS NOT NULL AND last_completed_at IS NULL" ]
  named_scope :reviewable,  :conditions => { :voted_digitally => true }, :order => "status, name, id"
  named_scope :returned,    :conditions => { :voted_digitally => true }
  named_scope :unreviewed,  :conditions => { :last_reviewed_at => nil }
  named_scope :reviewed,    :conditions => "last_reviewed_at IS NOT NULL"
  named_scope :confirmed,   :conditions => { :status => "confirmed" }
  named_scope :denied,      :conditions => { :status => "denied" }

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
    Digest::SHA1.hexdigest(pin.to_s.gsub(/[^0-9A-Z]/i, '').upcase)
  end

  def processed_at
    ballot && ballot.pdf_updated_at
  end
  
  def register_flow_completion!(voting_type)
    self.update_attributes!(:last_completed_at => Time.now)
    self.flow_completions.find_or_create_by_voting_type(voting_type)
  end
  
  def register_check_in!
    self.checked_in_at = Time.now
    self.save!
  end
  
  def register_ballot!(ballot_pdf)
    ballot = self.build_ballot(:pdf => ballot_pdf)

    if ballot.save
      self.update_attributes!(:voted_digitally => true)
    end

    ballot
  end
  
  def update_status(voter_params, reviewer)
    voter_params  ||= {}
    new_status      = voter_params[:status]
    new_deny_reason = voter_params[:deny_reason]
    new_deny_reason = nil if new_status != 'denied'
    
    result = true
    # Don't update if blank, but log
    if new_status.blank? || (result = self.update_attributes(:status => new_status, :deny_reason => new_deny_reason, :reviewer_id => reviewer.id, :last_reviewed_at => Time.zone.now))
      self.ballot.accept! if confirmed? && self.ballot
      log_action(new_status, new_deny_reason, reviewer)
    end

    result
  end

  def reviewable?
    self.voted_digitally?
  end
  
  def reviewed?
    %w{ confirmed denied }.include?(self.status)
  end
  
  def confirmed?
    self.status == "confirmed"
  end
  
  def denied?
    self.status == "denied"
  end
  
  def unconfirmed?
    self.status.blank?
  end
  
  def log_action(status, deny_reason, reviewer)
    case status
    when 'confirmed'
      LogRecord::Confirmed.create(:reviewer => reviewer, :registration => self)
    when 'denied'
      LogRecord::Denied.create(:reviewer => reviewer, :registration => self, :deny_reason => deny_reason)
    else
      LogRecord::Skipped.create(:reviewer => reviewer, :registration => self)
    end
  end
end
