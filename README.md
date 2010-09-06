DC Digital VBM
==============


Requirements
------------

* Ruby 1.8+ (tested on Ruby 1.8.7)
* RubyGems 1.3.6+ (tested on Ruby 1.3.6)
* Bundler 0.9.26


Installation
------------

Get the Bundler:

    $ sudo gem install bundler --version=0.9.26
  
Get the sources:

    $ git clone git://github.com/trustthevote/DCdigitalVBM.git

Install gem requirements:

    $ cd DCdigitalVBM
    $ bundle install

Configure the database (change your username / password):
  
    $ cp config/database.yml{.sample,}
    $ rake db:setup

Start the application:

    $ script/server


Sqlite3 Configuration
---------------------

If you want to try it with Sqlite3 instead of MySQL, follow these steps:

Change Gemfile to contain:

    gem 'sqlite3-ruby'

... instead of:

    gem 'mysql'
    
Install gems:

    $ bundle install --relock

Change database.yml to:

    development:
      adapter: sqlite3
      database: db/development.sqlite3
      pool: 5
      timeout: 5000

Initialize database with:

    $ rake db:setup

Start the application:

    $ script/server


Deployment
----------

Before you start, make sure that you have:

* Server IP or domain name you are going to deploy to
* User account on that server
* Empty database and username / password to use
* Apache with Passenger installed on the server

Create the app folder by SSH'ing into the server and creating the directory in your
deployment user home (we'll assume it's dc\_digital\_vbm).

Depending on whether it's your Staging or Production environment, open the _config/deploy/staging.rb_ or _production.rb_ and put in your _domain_, _user_
and _runner_ info (_user_ and _runner_ are likely to be the same). Next, open
_config/deploy.rb_ and change _application_ to the name of the folder that you created
under your home.

