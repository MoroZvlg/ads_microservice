ENV['SINATRA_ENV'] ||= 'development'

require 'bundler'
Bundler.require(:default, ENV['SINATRA_ENV'])

module InitMicroApp

  extend self

  def load_app
    load_db
    check_migrations
    require_app
  end

  def load_db
    $db = Sequel.connect(adapter: :postgres, database: 'ads_microservice', host: 'localhost', user: 'postgres', port: 5432)
  end

  private

  def require_app
    Dir["./app/*/*.rb"].each {|file| require file }
    require 'sinatra/json'
    require_relative './micro_application'
  end


  def check_migrations
    Sequel.extension :migration
    Sequel::Migrator.check_current($db, "db/migrations")
  end
end


