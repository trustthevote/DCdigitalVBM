set :domain,    "10.1.x.x"
set :rails_env, "staging"
set :deploy_to, "/home/boeuser/#{application}"
set :user,      "boeuser"
set :runner,    "boeuser"

role :app, domain
role :web, domain
role :db,  domain, :primary => true
