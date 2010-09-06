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
