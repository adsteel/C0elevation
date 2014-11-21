source 'https://rubygems.org'
ruby '2.0.0'

gem 'rails', '4.0.3'
gem 'pg'
gem 'thread_safe', '0.2.0' #forcing to 0.2.0 for pg gem compliance on Dengler's computer only.
gem 'devise'
gem 'turbolinks' #beware of javascript bugs!
gem 'thin'
gem 'stripe'
gem 'mail'
gem 'friendly_id', '~> 5.0.0'
gem 'geocoder'
#gem 'delayed_job_active_record'
gem 'numbers_in_words'

# Assets
gem 'jquery-rails'
gem 'jquery-turbolinks'
gem 'sass-rails', '~> 4.0.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'uglifier', '>= 1.3.0'
gem "font-awesome-rails"
gem 'normalize-rails'
gem 'bootstrap-sass'
gem "paperclip", "3.5.4"
gem 'aws-sdk'


# Background jobs
#gem 'redis'
gem 'sidekiq'
gem 'sinatra', require: false
gem 'slim'

# Illustrates current model design.
gem 'annotate'

# for Heroku asset compilation
gem 'rails_12factor', '0.0.2'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'


group :doc do
	# bundle exec rake doc:rails generates the API under doc/api.
	gem 'sdoc', require: false
end

group :development, :test do
	gem 'rspec-rails', '~> 3.0.0.beta'
	gem 'dotenv-rails'
  
  # heroku
	gem 'foreman'
  
  # testing
	gem 'capybara'
	gem 'factory_girl_rails'
	gem 'database_cleaner'
  gem 'launchy'
  
  # working tools
	gem 'guard'
	gem 'guard-annotate'
	gem 'guard-rspec', require: false
	gem 'guard-livereload', require: false
  gem 'byebug'
end
  
# Use ActiveModel has_secure_password
gem 'bcrypt-ruby', '~> 3.1.2'
