namespace :generate do
  desc "Generate Migration"
  task :migration, [:class_name] do |t, args|
    require 'active_support/core_ext/string/inflections' #underscore method

    path = File.expand_path('db/migrations')
    time_now = Time.now.utc.strftime('%Y%m%d%H%M%S')

    class_name = args[:class_name].to_s
    file_name = "#{time_now}_#{class_name.underscore}.rb"

    File.open("#{path}/#{file_name}", 'w') do |file|
      file << "Sequel.migration do\n"
      file << "  up do\n"
      file << "  end\n"
      file << "  down do\n"
      file << "  end\n"
      file << "end"
    end

    puts "Migration db/migrations/#{file_name}.rb created!"

  end
end