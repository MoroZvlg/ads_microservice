module ApplicationLoader
  extend self

  def load_app!
    init_settings
    init_db
    check_migrations
    require_lib
    require_app
    init_app
  end

  def init_db
    require_file 'config/initializers/db.rb'
  end

  def init_settings
    require_file 'config/initializers/config.rb'
  end

  private

  def check_migrations
    Sequel.extension :migration
    Sequel::Migrator.check_current(Sequel::Model.db, "db/migrations")
  end

  def init_app
    require_dir 'config/initializers'
  end

  def require_lib
    require_dir 'lib/'
  end

  def require_app
    require_dir 'app/helpers'
    require_file 'config/application'
    require_dir 'app/', pattern: "application*.rb"
    require_dir 'app/'
  end

  def require_file(path)
    require File.join(root, path)
  end

  def require_dir(path, pattern: "*.rb")
    path = File.join(root, path)
    Dir["#{path}**/#{pattern}"].each {|file| require file }
  end

  def root
    File.expand_path('..', __dir__)
  end
end