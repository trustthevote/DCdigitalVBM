class PagesController < ApplicationController

  before_filter :load_registration, :only => :confirm

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
  
  private
  
  def perform_check
    r = params[:registration]
    return if r.nil?
    
    # Find the registration and remember it
    @registration = Registration.first(:conditions => { :name => r[:name], :pin => r[:pin] })
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
