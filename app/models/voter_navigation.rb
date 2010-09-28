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

class VoterNavigation < Navigation

  def initialize(current_voter = nil)
    @current_voter = current_voter
  end
  
  def previous_item
    nav_items[:previous]
  end
  
  def next_item
    nav_items[:next]
  end
  
  private
  
  def nav_items
    @nav_items ||= begin
      n = p = nil
      
      if @current_voter
        reviewable = Registration.reviewable.all(:select => 'id')
        reviewable = reviewable.map { |r| r.id }
        current_index = reviewable.index(@current_voter.id)

        if current_index
          p_index = current_index - 1
          p_id    = p_index >= 0 ? reviewable[p_index] : nil
          
          n_index = current_index + 1
          n_id    = n_index < reviewable.size ? reviewable[n_index] : nil
          
          ids = [ p_id, n_id ].compact.uniq
          if ids.any?
            (Registration.find(ids) rescue []).each do |item|
              n = item if item.id == n_id
              p = item if item.id == p_id
            end
          end
        end
      end
      
      { :next => n, :previous => p }
    end
  end
  
end