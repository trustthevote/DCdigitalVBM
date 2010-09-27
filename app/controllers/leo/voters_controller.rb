class Leo::VotersController < Leo::BaseController

  before_filter :load_voter, :only => [ :show, :attestation ]

  def show
    @voter = voter_to_review(params[:id])
    @nav = VoterNavigation.new(@voter)
  end

  def attestation
    @registration = Registration.find(params[:id])
    prawnto :filename => "attestation.pdf", :prawn => { :page_size => "LETTER" }
    render  :template => "pages/attestation", :layout => false
  end
  
  private

  def load_voter
  end
  
  def voter_to_review(id)
    Registration.find(id) rescue Registration.reviewable.first
  end
  
end
