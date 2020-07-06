# frozen_string_literal: true

source "https://rubygems.org"

git_source(:github) {|repo_name| "https://github.com/#{repo_name}" }

gem 'puma'
gem 'sinatra', require: 'sinatra/base'
gem 'sinatra-contrib'


gem 'sequel'
gem 'sequel-seed'
gem 'pg'

gem 'i18n'
gem 'config'

gem 'fast_jsonapi'
gem 'activesupport', require: false

gem 'dry-initializer'
gem 'dry-validation'

gem 'faraday'
gem 'faraday_middleware'

group :test do
  gem 'rspec'
  gem 'factory_bot'
  gem 'rack-test'
  gem 'database_cleaner-sequel'
end