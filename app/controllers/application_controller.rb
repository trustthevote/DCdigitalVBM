# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password

  helper_method :voting_type, :physical?, :digital?

  def voting_type=(type)
    session[:voting_type] = type.to_s if %w( digital physical ).include?(type.to_s)
  end
  
  def voting_type
    session[:voting_type] || "physical"
  end

  def physical?
    voting_type == "physical"
  end
  
  def digital?
    !physical?
  end
  
end
