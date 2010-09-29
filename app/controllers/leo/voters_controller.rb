class Leo::VotersController < Leo::BaseController

  VOTERS_PER_PAGE = 15

  def index
    @voters = Registration.reviewable.paginate(:page => params[:page], :per_page => VOTERS_PER_PAGE)
  end
  
  def show
    @voter    ||= voter_to_review(params[:id])
    @next_voter = VoterNavigation.new.next(@voter)
  end

  def attestation
    @registration = Registration.find(params[:id])
    prawnto :filename => "attestation.pdf", :prawn => { :page_size => "LETTER" }
    render  :template => "pages/attestation", :layout => false
  rescue ActiveRecord::RecordNotFound
    render :text => ''
  end

  def update
    @voter = Registration.find(params[:id]) rescue nil

    @voter.update_status(params[:registration], current_user) if @voter

    # Get the next pair
    vn = VoterNavigation.new
    @voter      = vn.next(@voter)
    @next_voter = vn.next(@voter)
    
    render :show
  end
  
  private

  def voter_to_review(id)
    Registration.find(id) rescue VoterNavigation.new.next
  end
  
end
