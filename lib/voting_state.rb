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