set :domain,    "10.1.x.x"
set :rails_env, "production"
set :user,      "boeuser"
set :runner,    user
set :deploy_to, "/home/#{user}/#{application}"
set :bundle_path, "/opt/ruby-enterprise-1.8.7-2010.02/bin/bundle"

role :app, domain
role :web, domain
role :db,  domain, :primary => true
