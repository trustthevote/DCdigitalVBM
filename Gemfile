source :gemcutter

gem 'rails', '2.3.8'
gem 'rake', '0.8.7'
gem 'haml'
gem 'mysql'
gem 'simple_form', '1.0.2'
gem 'RedCloth'
gem 'paperclip'
gem 'prawn'
gem 'fastercsv'
gem 'subdomain_routes'
gem 'authlogic'

# Yes, this is weird, but is necessary for the correct deployment under Passenger 2.2.13+
# See http://github.com/carlhuda/bundler/issues/issue/349
gem 'bundler', '0.9.26'

group :development do
  gem 'mongrel'
  gem 'capistrano'
  gem 'capistrano-ext'
  gem 'radix'
end

group :development, :test do
  gem 'faker'
end

group :test, :cucumber do
  gem 'factory_girl'
end

group :test do
  gem 'rspec'
  gem 'rspec-rails'
  gem 'timecop'
  gem 'capybara'
  gem 'database_cleaner'
  gem 'cucumber-rails'
  gem 'mocha', :require => nil # This is important. Otherwise you won't be able to mock finders
end
