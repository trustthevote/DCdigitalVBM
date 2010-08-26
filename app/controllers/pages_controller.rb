class PagesController < ApplicationController

  before_filter :load_registration, :only => [ :confirm, :complete, :return ]

  def front
  end

  def overview
    self.voting_type = params[:voting_type] if params[:voting_type]
  end

  def check_in
    forget_registration
    perform_check if request.post?
  end

  def confirm
    # This line is necessary as we call the method from #perform_check
    render :confirm
  end
  
  def complete
  end
  
  def return
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
  
end
