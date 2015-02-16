source 'https://rubygems.org'

gem 'rails'
# Use sqlite3 as the database for Active Record

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

group :production do
  gem 'pg'
  gem 'rails_12factor' # for heroku
end


#gem 'protected_attributes'

#authorize
gem 'devise' , '3.2.0'
gem 'devise_ldap_authenticatable'
gem 'cancancan'
gem 'rolify'
gem 'activeadmin', github: 'gregbell/active_admin'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails'
  gem 'coffee-rails'
  gem 'uglifier', '>= 1.0.3'
end

gem 'twitter-bootstrap-rails'
gem "less-rails"
gem "therubyracer"
gem "haml-rails"

gem 'jquery-rails'
gem 'jquery-validation-rails'
gem 'wice_grid'

gem 'simple_form'
group :development, :test do
  gem 'sqlite3'
  gem 'rspec-rails'
  gem 'database_cleaner'
  gem 'guard-rspec'
  gem 'capybara'
  gem 'launchy'
  gem 'populator'

  # human console
  gem 'pry'
  gem 'pry-rails'
  gem 'pry-remote'
end

gem 'factory_girl_rails'
gem 'faker'

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'debugger'

#ruby "2.1.2"
