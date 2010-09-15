set :domain,    "10.1.143.74"
set :rails_env, "staging"
set :user,      "boeuser"
set :runner,    user
set :deploy_to, "/home/#{user}/#{application}"
  
role :app, domain
role :web, domain
role :db,  domain, :primary => true
