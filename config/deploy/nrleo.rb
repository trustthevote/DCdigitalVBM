set :domain,    "174.129.222.54"
set :rails_env, "staging"
set :user,      "ec2-user"
set :runner,    user
set :deploy_to, "/home/#{user}/dcdvbm"
set :branch,    "leo"
  
role :app, domain
role :web, domain
role :db,  domain, :primary => true
