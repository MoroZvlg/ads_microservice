namespace :db do
  desc "Run seeds"
  task :seed, [:version] do |t, args|
    require "sequel/core"
    require 'sequel/extensions/seed'
    require_relative '../../config/environment.rb'

    Sequel.connect(Settings.db.url || Settings.db.to_hash) do |db|
      Sequel.extension :seed
      Sequel::Seed.setup(ENV['RACK_ENV'].to_sym)

      Sequel::Seeder.apply(db, "db/seeds")
    end
  end
end
