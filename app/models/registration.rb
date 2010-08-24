require 'digest/sha1'

class Registration < ActiveRecord::Base

  validates_presence_of :pin_hash
  
  def self.match(r)
    first(:conditions => {
      :name     => r[:name],
      :pin_hash => Digest::SHA1.hexdigest(r[:pin]),
      :zip      => r[:zip],
      :voter_id => r[:voter_id] })
  end

  def pin=(v)
    self.pin_hash = Digest::SHA1.hexdigest(v)
  end

end
