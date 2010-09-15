source :gemcutter

gem 'rails', '2.3.8'
gem 'rake', '0.8.7'
gem 'haml'
gem 'mysql'
gem 'hoptoad_notifier'
gem 'simple_form', '1.0.2'
gem 'RedCloth'
gem 'paperclip'

group :development do
  gem 'mongrel'
  gem 'capistrano'
  gem 'capistrano-ext'
  gem 'radix'
  gem 'fastercsv'
end

group :development, :test do
  gem 'faker'
end

group :test do
  gem 'rspec'
  gem 'rspec-rails'
  gem 'timecop'
  gem 'factory_girl'
  gem 'mocha', :require => nil # This is important. Otherwise you won't be able to mock finders
end
