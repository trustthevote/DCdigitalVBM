set :domain,    "10.1.143.74"
set :rails_env, "staging"
set :user,      "boeuser"
set :runner,    user
set :deploy_to, "/home/#{user}/#{application}"
default_environment["PATH"] = "/bin:/usr/bin:/usr/local/bin:/opt/ruby-enterprise-1.8.7-2010.02/bin"
  
role :app, domain
role :web, domain
role :db,  domain, :primary => true
