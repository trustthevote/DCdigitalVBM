class Leo::VotersController < Leo::BaseController

  VOTERS_PER_PAGE = 15

  def index
    @voters = Registration.reviewable.paginate(:page => params[:page], :per_page => VOTERS_PER_PAGE)
  end
  
  def show
    @voter    ||= voter_to_review(params[:id])
    @next_voter = VoterNavigation.next(@voter)
  end

  def attestation
    @registration = Registration.find(params[:id])
    render_pdf "attestation", "pages/attestation"
  rescue ActiveRecord::RecordNotFound
    render :text => ''
  end

  def update
    @voter = Registration.find(params[:id]) rescue nil

    @voter.update_status(params[:registration], current_user) if @voter

    # Get the next pair
    @voter      = VoterNavigation.next(@voter)
    @next_voter = VoterNavigation.next(@voter)
    
    render :show
  end
  
  private

  def voter_to_review(id)
    Registration.find(id) rescue VoterNavigation.next
  end
  
end
