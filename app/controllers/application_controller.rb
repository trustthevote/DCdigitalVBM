# Version: OSDV Public License 1.2
# The contents of this file are subject to the OSDV Public License
# Version 1.2 (the "License"); you may not use this file except in
# compliance with the License. You may obtain a copy of the License at
# http://www.osdv.org/license/
# Software distributed under the License is distributed on an "AS IS"
# basis, WITHOUT WARRANTY OF ANY KIND, either express or implied.
# See the License for the specific language governing rights and limitations
# under the License.
# 
# The Original Code is:
# 	TTV UOCAVA Ballot Portal.
# The Initial Developer of the Original Code is:
# 	Open Source Digital Voting Foundation.
# Portions created by Open Source Digital Voting Foundation are Copyright (C) 2010.
# All Rights Reserved.
# 
# Contributors: Paul Stenbjorn, Aleksey Gureiev, Robin Bahr,
# Thomas Gaskin, Sean Durham, John Sebes.

# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base

  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password

  helper_method :voting_type, :physical?, :digital?, :before_voting?, :after_voting?, :during_voting?, :digital_enabled?, :warning_enabled?

  def voting_type=(type)
    session[:voting_type] = type if type.nil? || %w( digital physical ).include?(type.to_s)
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

  def digital_enabled?
    !AppConfig['digital_enabled']
  end

  def warning_enabled?
    AppConfig['warning_enabled']
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

  def default_url_options(options = nil)
    { :protocol => 'https' } unless Rails.env == 'development'
  end

  def render_pdf(name, template = nil)
    response.headers['Content-Disposition'] = "attachment;filename=\"#{name}.pdf\""
    response.headers['Content-Description'] = 'File Transfer'
    response.headers['Content-Transfer-Encoding'] = 'binary'
    response.headers['Expires'] = '0'
    response.headers['Pragma'] = 'public'

    prawnto :filename => "#{name}.pdf", :prawn => { :page_size => "LETTER" }

    render_options = { :layout => false }
    render_options[:template] = template if template
    render render_options
  end
end
