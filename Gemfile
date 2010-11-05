source :gemcutter

gem 'rails',              '2.3.8'
gem 'rake',               '0.8.7'
gem 'haml',               '3.0.21'
gem 'mysql',              '2.8.1'
gem 'simple_form',        '1.0.2'
gem 'RedCloth',           '4.2.3'
gem 'paperclip',          '2.3.3'
gem 'prawn',              '0.8.4'
gem 'fastercsv',          '1.5.3'
gem 'subdomain_routes',   '0.3.1'
gem 'authlogic',          '2.1.6'
gem 'will_paginate',      '2.3.15'

# Yes, this is weird, but is necessary for the correct deployment under Passenger 2.2.13+
# See http://github.com/carlhuda/bundler/issues/issue/349
gem 'bundler',            '0.9.26'

group :development do
  gem 'sqlite3-ruby',     '1.3.1'
  gem 'mongrel',          '1.1.5'
  gem 'capistrano',       '2.5.19'
  gem 'capistrano-ext',   '1.2.1'
  gem 'radix',            '1.1.0'
end

group :development, :test, :cucumber do
  gem 'faker',            '0.3.1'
end

group :test, :cucumber do
  gem 'factory_girl',     '1.3.2'
  gem 'capybara',         '0.3.9'
  gem 'cucumber-rails',   '0.3.2'
  gem 'database_cleaner', '0.5.2'
end

group :test do
  gem 'rspec',            '1.3.0'
  gem 'rspec-rails',      '1.3.2'
  gem 'timecop',          '0.3.5'
  gem 'mocha',            '0.9.8', :require => nil # This is important. Otherwise you won't be able to mock finders
end
