class Leo::VotersController < Leo::BaseController

  def show
    @voter ||= voter_to_review(params[:id])
    @nav = VoterNavigation.new(@voter)
    render :show
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

    if @voter
      @voter.update_status(params[:registration], current_user)
    else
      @voter = Registration.reviewable.first
    end
    
    show
  end
  
  private

  def voter_to_review(id)
    Registration.find(id) rescue Registration.reviewable.first
  end
  
end
