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

  ERROR_NAME = "Please upload the ballot file with the same name that you downloaded"
  
  belongs_to :registration

  has_attached_file :pdf, :path => ':rails_root/ballots/:ballot_name.pdf.gpg',
                          :url  => '/', # Disallow external access
                          :styles => { :original => AppConfig['gpg_recipient'] },
                          :processors => [ :encrypt ]

  validates_presence_of   :registration_id, :on => :create
  # validates_attachment_presence       :pdf, :message => "must be chosen"
  # validates_attachment_content_type   :pdf, :content_type => "application/pdf", :message => "must be PDF file"

  validate :validate_pdf, :on => :create
  
  private
  
  def validate_pdf
    if registration
      filename = registration.blank_ballot.original_filename
      fn_parts = filename.split(".")
      self.errors.add_to_base(ERROR_NAME) unless self.pdf.original_filename.include?(fn_parts[0])
    end
  end
  
end
