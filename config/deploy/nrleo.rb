set :domain,    "75.101.128.188"
set :rails_env, "staging"
set :user,      "ec2-user"
set :runner,    user
set :deploy_to, "/home/#{user}/dcdvbm2"
set :branch,    "leo"
  
role :app, domain
role :web, domain
role :db,  domain, :primary => true
