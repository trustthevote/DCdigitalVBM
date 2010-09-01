class Ballot < ActiveRecord::Base

  ERROR_NAME = "Please upload the ballot file with the same name that you downloaded"
  
  belongs_to :registration

  has_attached_file :pdf, :path => ':rails_root/ballots/:id',
                          :url  => '/', # Disallow external access
                          :styles => { :pdf => {} },
                          :processors => [ :encrypt ]

  validates :registration_id, :presence => true, :on => :create
  validates_attachment_presence       :pdf
  validates_attachment_content_type   :pdf, :content_type => "application/pdf"
  
  validate :validate_pdf, :on => :create
  
  private
  
  def validate_pdf
    if registration
      filename = registration.blank_ballot.original_filename
      self.errors[:base] << ERROR_NAME if self.pdf.original_filename != filename
    end
  end
  
end
