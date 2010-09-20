# Version: OSDV Public License 1.2
# "The contents of this file are subject to the OSDV Public License
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

class CreateBallots < ActiveRecord::Migration
  def self.up
    create_table :ballots do |t|
      t.integer   :registration_id

      t.string    :pdf_file_name
      t.string    :pdf_content_type
      t.integer   :pdf_file_size
      t.datetime  :pdf_updated_at
    end
    
    add_index :ballots, :registration_id, :unique => true
  end

  def self.down
    drop_table :ballots
  end
end
