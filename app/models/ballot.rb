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

class Ballot < ActiveRecord::Base

  ERROR_NAME = "Please upload the ballot file with the same name that you downloaded."
  ERROR_SIZE = "Invalid ballot file submitted. Please re-select and check your ballot file, and try again."
  
  attr_accessor :uploaded_pdf_size
  
  belongs_to :registration

  has_attached_file :pdf, :path => ':rails_root/ballots/:ballot_name.pdf.gpg',
                          :url  => '/', # Disallow external access
                          :styles => { :original => AppConfig['gpg_recipient'] },
                          :processors => [ :encrypt ]

  validates_presence_of   :registration_id, :on => :create
  validate                :validate_pdf, :on => :create
  
  def pdf=(file)
    self.uploaded_pdf_size = file && file.try(:size).to_i
    attachment_for(:pdf).assign(file)
  end
  
  # Moves the file to a secure accepted ballots location and deletes the self
  def accept!
    raise "No ballot file to anonymize" if self.pdf.nil?
    
    scrambled_name = Digest::SHA1.hexdigest("#{File.basename(self.pdf.path)}#{Time.now.to_i}")
    accepted_path  = "#{Rails.root}/accepted_ballots"

    FileUtils.mkdir_p(accepted_path)
    FileUtils.cp(self.pdf.path, "#{accepted_path}/#{scrambled_name}.pdf.gpg")

    self.destroy
  end
  
  private
  
  def validate_pdf
    if self.registration
      if self.pdf.blank?
        self.errors.add_to_base(ERROR_NAME)
      else
        validate_pdf_name
        validate_pdf_size
      end
    end
  end
  
  def validate_pdf_name
    filename    = self.registration.blank_ballot.original_filename
    fn_parts    = filename.split(".")
    self.errors.add_to_base(ERROR_NAME) unless self.pdf.original_filename.include?(fn_parts[0])
  end

  def validate_pdf_size
    blank_size  = self.registration.blank_ballot.size
    range       = (blank_size / 2 .. blank_size * 5)

    self.errors.add_to_base(ERROR_SIZE) unless range.include?(self.uploaded_pdf_size)
  end
end
