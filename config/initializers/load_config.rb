AppConfig = YAML.load_file(File.join(RAILS_ROOT, 'config', 'config.yml'))

# Override config options by correct environment
env_options = AppConfig.delete(RAILS_ENV)
AppConfig.merge!(env_options) unless env_options.nil?
