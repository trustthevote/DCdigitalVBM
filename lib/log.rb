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

class Log

  # Print log for a given reviewer or all of them
  def print(reviewer = nil)
    # See if we can find a reviewer
    if reviewer && !reviewer.is_a?(User)
      reviewer = User.find_by_login(reviewer)
    end
    
    # Add reviewer condition
    options = { :include => [ :reviewer, :registration ] }
    if reviewer
      options = { :conditions => { :reviewer_id => reviewer.id } }
    end
    
    LogRecord::Base.find_in_batches(options) do |records|
      records.each { |record| puts record.description }
    end
  end

end