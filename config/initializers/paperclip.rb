Paperclip.interpolates :ballot_name do |attachment, style|
  r = attachment.instance.registration
  Digest::SHA1.hexdigest("#{r.id}-#{r.name}-#{r.zip}-#{r.address}-#{r.pin_hash}")
end