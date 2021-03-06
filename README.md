DC Digital VBM
==============


Requirements
------------

* Ruby 1.8+ (tested on Ruby 1.8.7)
* RubyGems 1.3.6+ (tested on RubyGems 1.3.6)
* Bundler 0.9.26
* GnuPG (gnupg.org) with the public key for ballots signing 

Installation (locally)
----------------------

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

Configure the application:

    $ cp config/config.yml{.sample,}

Install the PGP public key that will be used for ballots signing. You either get this
key from the authority or generate it yourself (with "gpg --gen-key") for testing.

    $ gpg --import key.asc

Put the generated key ID (like 95ED022D) into the _gpg\_recepient_ field of _config/config.yml_.

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


Deployment (to remote server)
-----------------------------

Before you start, make sure that you have:

* Server IP or domain name you are going to deploy to
* User account on that server
* Empty database and username / password to use
* Apache with Passenger installed on the server

Install Capistrano and Capistrano Ext gems (tested with versions 2.5.19 and 1.2.1):

    $ sudo gem install capistrano capistrano-ext

Create the app folder by SSH'ing into the server and creating the directory in your
deployment user home (we'll assume it's dc\_digital\_vbm).

Depending on whether it's your Staging or Production environment, open the _config/deploy/staging.rb_ or _production.rb_ and put in your _domain_, _user_
and _runner_ info (_user_ and _runner_ are likely to be the same). Next, open
_config/deploy.rb_ and change _application_ to the name of the folder that you created
under your home.

In the commands below replace <env> with whatever environment (production or staging)
you chose to deploy to.

Initialize your application:

    $ cap <env> deploy:setup
    $ cap <env> deploy:config:db -s dbname=<db> -s username=<dbu> -s password=<dbp>
    $ cap <env> deploy:config:app -s email=<email> -s domain=<domain> -s gpg_key_id=<key>

... where:

  * _db_, _dbu_, _dbp_ -- your database name, username and password
  * _email_ -- support email address that will appear in From fields of letters from the app
  * _domain_ -- domain name the app will be accessible from (i.e. dcdvbm.com)
  * _key_ -- GPG public key ID to use for ballots encryption (i.e. 95ED0777)

Perform a cold install:

    $ cap <env> deploy:cold

Finally, create a VirtualHost entry in your Apache config and point the DocumentRoot to
the _public_ folder of your app.



Switching voting state
----------------------

At any given moment, the application can be in one of three voting states:

* Before the voting has begun
* During the period
* After the voting has finished

Depending on the voting state, your users will see different information on the
front page, and the application logic will be slightly altered to disallow voting
during the inactivity periods.

To switch between the three, you can use the following rake tasks:

    $ rake vbm:voting_state:before
    $ rake vbm:voting_state:during
    $ rake vbm:voting_state:after



Importing data
--------------

To import registration data, you will need two artifacts:

* The list of voter records in a CSV file (see db/fixtures/voters.csv for the format example)
* The archive of ballots used by the registrations (see db/fixtures/ballots.zip)

Once you have them both, you can run the following rake task:

    $ rake vbm:import voter_csv=path/to/voter.csv ballots_zip=path/to/ballots.zip

It will extract the ballots and reload your database with new voter records.



Statistics
----------

During the normal operation the application records different milestones in user activity, such as:

* Checking in and confirming identity
* Finishing the workflow by entering the Thanks page
* Uploading ballot

At any moment, you can request live statistics by invoking a command-line task:

    $ rake vbm:stats

The sample output is:

    $ rake vbm:stats
    Total number of voters                            : 3201
    Inactive                                          : 3200 ( 99.97%)
    Used the system but not finished                  : 0 (  0.00%)
    Used the system and finished                      : 1 (  0.03%)



Attestation Review
------------------

After the voting finished, the attestations can be reviewed at <your_app_domain>/leo.
You will need at least one LEO user registered to be able to log into the reviewing
area.

You can add reviewers using the rake task 'leo:add_reviewer', like this:

    $ rake leo:add_reviewer login=mark email=mark@some.com password=pass

Now the user can log in with the user name 'mark' and password 'pass'.

The review screen lets the user to confirm, deny (with the reason) or skip voter
records.

All actions are logged, and the log can be displayed with the rake task 'leo:log', like
this:

    $ rake leo:log reviewer=mark
    
Or for all reviewers:

    $ rake leo:log



Hint: Local DNS config
----------------------

In order to work with the LEO part locally, you need a subdomain configured as it's
the only way to access this portion of the app. To configure that locally you need
to use a DNS configuration trick which is very easy and will come in handy in your
future work.

1. Open the hosts file:
  * Windows: c:\windows\system32\drivers\etc\hosts
  * Unix and Mac OS X: /etc/hosts

2. Add this line to configure virtual domain names:

  127.0.0.1 vbm.local leo.vbm.local

3. Save and close the file, restart (important!) your browser

Having done this, you should be able to access the main part of the application
locally at:

    http://vbm.local:3000/

... and the LEO part at:

    http://leo.vbm.local:3000/
  

