class Ballot < ActiveRecord::Base

  ERROR_NAME = "Please upload the ballot file with the same name that you downloaded"
  
  belongs_to :registration

  has_attached_file :pdf, :path => ':rails_root/ballots/:id.pdf.gpg',
                          :url  => '/', # Disallow external access
                          :styles => { :encrypt => AppConfig['gpg_recipient'] },
                          :processors => [ :encrypt ]

  validates_presence_of   :registration_id, :on => :create
  validates_attachment_presence       :pdf
  validates_attachment_content_type   :pdf, :content_type => "application/pdf"
  
  validate :validate_pdf, :on => :create
  
  private
  
  def validate_pdf
    if registration
      filename = registration.blank_ballot.original_filename
      self.errors.add_to_base(ERROR_NAME) if self.pdf.original_filename != filename
    end
  end
  
end
