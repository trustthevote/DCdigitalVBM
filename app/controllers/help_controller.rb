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

class HelpController < ApplicationController

  def show
    @section = sanitize(params[:section])
    @page    = sanitize(params[:page])
    
    if %w( general-questions vote-by-mail-process vote-by-mail ).include?(@section) ||
       (@section == 'security' && @page != 'index') ||
       (@section == 'absentee-voting' && @page != 'absentee-voting-options')
      render :template => "help/questions_page"
    else
      render :template => "help/#{@section}/#{@page}"
    end
  end

  private
  
  def sanitize(txt)
    txt.gsub(/[^a-z0-9\-]/i, '')
  end
  
end
