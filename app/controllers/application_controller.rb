# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password

  helper_method :voting_type, :physical?, :digital?, :before_voting?, :after_voting?, :during_voting?

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

  def before_voting?
    AppConfig['state'] == 'before'
  end
  
  def after_voting?
    AppConfig['state'] == 'after'
  end
  
  def during_voting?
    AppConfig['state'].blank? || AppConfig['state'] == 'during'
  end
end
