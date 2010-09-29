set :domain,    "noizeramp.com"
set :rails_env, "staging"
set :user,      "agureiev"
set :runner,    user
set :deploy_to, "/home/#{user}/domains/dcdvbm2.noizeramp.com"
  
role :app, domain
role :web, domain
role :db,  domain, :primary => true
