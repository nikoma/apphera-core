require "bundler/capistrano"

server ".apphera.com", :web, :app, primary: true

set :application, "api"
set :user, "deployer"
set :deploy_to, "/home/#{user}/apps/#{application}"
set :deploy_via, :remote_cache
set :use_sudo, true

set :scm, "git"
set :repository, "git@github.com:nikoma/apphera-core.git"
set :branch, "master"

default_run_options[:pty] = true
ssh_options[:forward_agent] = true

after "deploy", "deploy:cleanup" # keep only the last 5 releases

namespace :deploy do
  %w[start stop restart].each do |command|
    desc "#{command} unicorn server"
    task command, roles: :app, except: {no_release: true} do
      run "/etc/init.d/unicorn_#{application} #{command}"
    end
    # task :precompile, :role => :app do
    #         run "cd #{release_path}/ && RAILS_ENV=production bundle exec rake assets:precompile --trace"
    #       end
  end

  task :setup_config, roles: :app do
    #sudo "ln -nfs #{current_path}/config/nginx.conf /etc/nginx/sites-enabled/#{application}"
    sudo "ln -nfs #{current_path}/config/unicorn_init.sh /etc/init.d/unicorn_#{application}"
    run "mkdir -p #{shared_path}/config"
    put File.read("config/database.example.yml"), "#{shared_path}/config/database.yml"
    puts "Now edit the config files in #{shared_path}."
  end
  after "deploy:setup", "deploy:setup_config"

  task :symlink_config, roles: :app do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
    # run "mkdir /home/deployer/apps/appheradashboard/current/spool"
  end
  after "deploy:finalize_update", "deploy:symlink_config"

  desc "Make sure local git is in sync with remote."
  task :check_revision, roles: :web do
    unless `git rev-parse HEAD` == `git rev-parse origin/master`
      puts "WARNING: HEAD is not the same as origin/master"
      puts "Run `git push` to sync changes."
      exit
    end
  end
  before "deploy", "deploy:check_revision"

end

namespace :deploy do

end

# override original to trace the compile
# namespace :deploy do
#   namespace :assets do
#     desc <<-DESC
#       [internal] This task will set up a symlink to the shared directory \
#       for the assets directory. Assets are shared across deploys to avoid \
#       mid-deploy mismatches between old application html asking for assets \
#       and getting a 404 file not found error. The assets cache is shared \
#       for efficiency. If you cutomize the assets path prefix, override the \
#       :assets_prefix variable to match.
#     DESC
#     task :symlink, :roles => :web, :except => { :no_release => true } do
#       run <<-CMD
#         rm -rf #{latest_release}/public/#{assets_prefix} &&
#         mkdir -p #{latest_release}/public &&
#         mkdir -p #{shared_path}/assets &&
#         ln -s #{shared_path}/assets #{latest_release}/public/#{assets_prefix}
#       CMD
#     end
# 
#     desc <<-DESC
#       Run the asset precompilation rake task. You can specify the full path \
#       to the rake executable by setting the rake variable. You can also \
#       specify additional environment variables to pass to rake via the \
#       asset_env variable. The defaults are:
# 
#         set :rake,      "rake"
#         set :rails_env, "production"
#         set :asset_env, "RAILS_GROUPS=assets"
#     DESC
#     task :precompile, :roles => :web, :except => { :no_release => true } do
#       run "cd #{latest_release} && #{rake} RAILS_ENV=#{rails_env} #{asset_env} assets:precompile --trace"
#     end
# 
#     desc <<-DESC
#       Run the asset clean rake task. Use with caution, this will delete \
#       all of your compiled assets. You can specify the full path \
#       to the rake executable by setting the rake variable. You can also \
#       specify additional environment variables to pass to rake via the \
#       asset_env variable. The defaults are:
# 
#         set :rake,      "rake"
#         set :rails_env, "production"
#         set :asset_env, "RAILS_GROUPS=assets"
#     DESC
#     task :clean, :roles => :web, :except => { :no_release => true } do
#       run "cd #{latest_release} && #{rake} RAILS_ENV=#{rails_env} #{asset_env} assets:clean"
#     end
#   end
# end
