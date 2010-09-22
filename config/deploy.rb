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

set :stages,              %w(staging production nr)
set :default_stage,       "staging"
require 'capistrano/ext/multistage'

set :application,         "dcdvbm"
set :repository,          "git://github.com/trustthevote/DCdigitalVBM.git"

default_run_options[:pty] = true
ssh_options[:paranoid]    = false

set :use_sudo,            false

set :scm,                 :git
set :branch,              "master"

# don't use export as it will clear out the .git directories prematurely.
# we'll remove them ourselves later when we're done with using git
set :deploy_via,          :checkout

# set these values with proc-value to delay evaluation and properly handle overrides (e.g. deploy_to)
set(:current_path)        { "#{deploy_to}/current" }  # A hack since cap 2.3.0 uses /u/apps sometimes

# Create uploads directory and link, remove rep clone
task :setup, :roles => :app do
  run "cp #{shared_path}/config/database.yml #{release_path}/config/database.yml"
  run "cp #{shared_path}/config/config.yml #{release_path}/config/config.yml"
  run "ln -s #{shared_path}/assets #{release_path}/public/assets"
  run "ln -s #{shared_path}/ballots #{release_path}/ballots"
  run "rm -Rf #{release_path}/.git" if fetch(:deploy_to) != :export
  
  run "cd #{latest_release}; bundle install --without development test"
end
after 'deploy:update_code', 'setup'

namespace :deploy do
  namespace :config do
    desc "Configures database"
    task :db, :roles => :app do
      if !config[:dbname] || !config[:username] || !config[:password]
        p "Usage: rake deploy:config:db -s dbname=<name> -s username=<name> -s password=<pass>"
      else
        db_config = ERB.new <<-EOF
         production:
           adapter: mysql
           database: #{config[:dbname]}
           username: #{config[:username]}
           password: #{config[:password]}
           socket: /tmp/mysql.sock
         EOF

         run "mkdir -p #{shared_path}/config" 
         put db_config.result, "#{shared_path}/config/database.yml"
       end
    end
    
    desc "Configures application"
    task :app, :roles => :app do
      app_name    = config[:app_name] || "DC Digital VBM"
      email       = config[:email]
      domain      = config[:domain]
      gpg_key_id  = config[:gpg_key_id] || "DCdVBM"

      if !email || !domain
        p "Usage: rake deploy:config:app -s email=... -s domain=... [ -s app_name=... ] [ -s gpg_key_id=... ]"
      else
        app_config = ERB.new <<-EOF
          app_name:       #{app_name}
          from_email:     #{email}
          domain:         #{domain}
          gpg_recipient:  #{gpg_key_id}
        EOF

        run "mkdir -p #{shared_path}/config" 
        run "mkdir -p #{shared_path}/assets" 
        run "mkdir -p #{shared_path}/ballots" 
        put app_config.result, "#{shared_path}/config/config.yml"
      end
    end
  end
end

# Passenger tasks
namespace :deploy do  
  desc "Restarting mod_rails with restart.txt"
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{current_path}/tmp/restart.txt"
  end

  [:start, :stop].each do |t|
    desc "#{t} task is a no-op with mod_rails"
    task t, :roles => :app do ; end
  end
end

# Dir[File.join(File.dirname(__FILE__), '..', 'vendor', 'gems', 'hoptoad_notifier-*')].each do |vendored_notifier|
#   $: << File.join(vendored_notifier, 'lib')
# end
# 
# require 'hoptoad_notifier/capistrano'
