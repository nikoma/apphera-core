# # #{Rails.root}/lib/tasks/databases.rake
# =begin
#   Monkey Patch 
#   activerecord-3.0.9/lib/active_record/railties/databases.rake
#   clears obstinate stale PG session to get parallel_tests working
#   also, PG user must be superuser to use these low level PG functions
# =end
# def drop_database(config)
#   case config['adapter']
#   when /mysql/
#     ActiveRecord::Base.establish_connection(config)
#     ActiveRecord::Base.connection.drop_database config['database']
#   when /sqlite/
#     require 'pathname'
#     path = Pathname.new(config['database'])
#     file = path.absolute? ? path.to_s : File.join(Rails.root, path)
#  
#     FileUtils.rm(file)
#   when /postgresql/
#     ActiveRecord::Base.connection.select_all("select * from pg_stat_activity order by procpid;").each do |x|
#       if config['database'] == x['datname'] && x['current_query'] =~ /<IDLE>/
#         ActiveRecord::Base.connection.execute("select pg_terminate_backend(#{x['procpid']})")
#       end
#     end
#     ActiveRecord::Base.establish_connection(config.merge('database' => 'postgres', 'schema_search_path' => 'public'))
#     ActiveRecord::Base.connection.drop_database config['database']
#   end
# end