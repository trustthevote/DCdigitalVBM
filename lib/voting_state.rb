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

class VotingState
  
  def self.switch_to(state)
    config = read_config
    config = change_state(config, state)
    write_config(config)
    puts "Switched to #{state} voting state"

    restart
    puts "Restarting Passenger application"
  end
  
  private
  
  def self.read_config
    File.open(config_filename).read
  end
  
  def self.change_state(config, state)
    config.gsub(/^(\s*)state:.*$/, '\1' + "state: #{state}")
  end
  
  def self.write_config(config)
    File.open(config_filename, 'w').write(config)
  end

  def self.restart
    `touch "#{restart_filename}"`
  end
  
  def self.config_filename
    File.expand_path(File.join(File.dirname(__FILE__), '..', 'config', 'config.yml'))
  end

  def self.restart_filename
    File.expand_path(File.join(File.dirname(__FILE__), '..', 'tmp', 'restart.txt'))
  end
end