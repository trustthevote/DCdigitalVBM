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

namespace :vbm do
  desc "Generate sample seed records for db/fixtures"
  task :generate_test_seeds => :environment do
    SeedGenerator.new.run
  end
  
  desc "Display stats and the activity log"
  task :stats => :environment do
    Stats.new.run
  end
  
  namespace :voting_state do
    desc "Switches the voting into the 'before' state"
    task :before => :environment do
      VotingState.switch_to 'before'
    end

    desc "Switches the voting into the 'during' state"
    task :during => :environment  do
      VotingState.switch_to 'during'
    end

    desc "Switches the voting into the 'after' state"
    task :after => :environment  do
      VotingState.switch_to 'after'
    end
  end
end
