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

class LogRecord::Base < ActiveRecord::Base

  set_table_name "log_records"

  belongs_to :reviewer, :class_name => "User"

  # We need it here to make efficient lookups in Log
  belongs_to :registration
  
  validates_presence_of :reviewer

  # Returns the human-readable action logged
  def action
    # Put the name of the action here in sub-classes (e.g. "Logged In")
  end
  
  def description
    "#{created_at.to_s(:us_with_time)}: #{reviewer.login.ljust(20, ' ')} - #{action_description}"
  end

  protected

  def action_description
    # Put the action description here in sub-classes (e.g. "Confirmed Mike" or "Denied Mike with reason: Too bad at chess")
  end
  
end
