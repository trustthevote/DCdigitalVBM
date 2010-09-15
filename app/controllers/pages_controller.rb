class PagesController < ApplicationController

  before_filter :load_registration, :only => [ :confirm, :attestation, :complete, :return, :thanks ]
  before_filter :block_processed,   :only => [ :confirm, :complete, :return ]

  def overview
    self.voting_type = params[:voting_type] if params[:voting_type]
  end

  def check_in
    forget_registration
    perform_check if request.post?
  end

  def confirm
  end

  def attestation
    prawnto :filename => "attestation.pdf", :prawn => { :page_size => "LETTER" }
    render :layout => false
  end
  
  def complete
    @registration.register_check_in!
  end
  
  def return
    if request.post? && save_ballot
      redirect_to thanks_url
    else
      render :return
    end
  end
  
  def thanks
    @registration.register_flow_completion!(voting_type)
  end
  
  private
  
  def perform_check
    r = params[:registration]
    return if r.nil?
    
    # Find the registration and remember it
    @registration = Registration.match(r)
    if @registration
      session[:rid] = @registration.id
      redirect_to confirm_url
    end
  end

  def forget_registration
    session[:rid] = nil
  end
  
  def load_registration
    unless session[:rid]
      redirect_to check_in_url
      return false
    else
      @registration = Registration.find(session[:rid])
    end
  end

  def save_ballot
    @ballot = @registration.build_ballot(:pdf => params[:pdf])
    @ballot.save
  end

  # Blocks registrations that have already been processed (uploaded their ballots)
  def block_processed
    if @registration && @registration.processed?
      redirect_to thanks_url
    end
  end
end
