namespace :db do
  desc "Run migrations"
  task :migrate, [:version] do |t, args|
    require "sequel/core"
    Sequel.extension :migration
    InitMicroApp.load_db
    version = args[:version].to_i if args[:version]
    Sequel::Migrator.run($db, "db/migrations", target: version)
  end
end