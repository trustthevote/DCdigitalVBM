class Leo::VotersController < Leo::BaseController

  def show
    @voter = voter_to_review(params[:id])
    @nav   = VoterNavigation.new
  end

  private
  
  def voter_to_review(id)
    Registration.reviewable.find(id) rescue Registration.reviewable.first
  end
  
end
