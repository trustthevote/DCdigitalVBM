require 'digest/sha1'

class Registration < ActiveRecord::Base

  belongs_to  :precinct_split
  has_one     :ballot, :dependent => :destroy

  has_attached_file :attestation, :path => ':rails_root/public/assets/attestations/:id.pdf',
                                  :url  => '/assets/attestations/:id.pdf'

  validates_presence_of :pin_hash
  validates_presence_of :precinct_split_id
  
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
end
