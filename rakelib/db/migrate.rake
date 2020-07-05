namespace :db do
  desc "Run migrations"
  task :migrate, [:version] => :settings do |t, args|
    require "sequel/core"

    Sequel.connect(Settings.db.to_hash) do |db|
      Sequel.extension :migration
      version = args[:version].to_i if args[:version]

      Sequel::Migrator.run(db, "db/migrations", target: version)
    end

    Rake::Task['db:generate_schema'].execute
  end

end