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
