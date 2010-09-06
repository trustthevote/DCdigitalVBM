set :domain,    "10.1.x.x"
set :rails_env, "production"
set :user,      "boeuser"
set :runner,    user
set :deploy_to, "/home/#{user}/#{application}"

role :app, domain
role :web, domain
role :db,  domain, :primary => true
