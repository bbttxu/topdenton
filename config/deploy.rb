require "bundler/capistrano"

default_run_options[:pty] = true  # Must be set for the password prompt from git to work
set :application, "top_denton"
set :scm, :git

set :repository, "ssh://198.199.123.28/~/repos/topdenton.git"  # Your clone URL
set :branch, "master"
set :user, "deploy"  # The server's user for deploys
set :deploy_via, :remote_cache # Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

set :rails_env, "production"
set :deploy_to, "/home/adam/#{application}"
set :user, "adam" # Login as?
set :use_sudo, false
set :hosts, ["192.241.212.23", "192.241.214.127", "192.241.220.139"]


# uyqisbumrkce

if ENV['DEPLOY'] == 'PRODUCTION'
   puts "*** Deploying to the \033[1;41m  PRODUCTION  \033[0m servers!"
   role :app, "50.56.247.244"                          # Your HTTP server, Apache/etc
   role :web, "50.56.247.244"                          # Your HTTP server, Apache/etc
   # TODO adding db role to production, we don't need it, but a capistrano task is looking for it
   role :db,  "50.56.247.244", :primary => true
else
   puts "*** Deploying to the \033[1;42m  STAGING  \033[0m server!"
   role :app, "192.241.212.23", "192.241.214.127", "192.241.220.139"                          # Your HTTP server, Apache/etc
   role :web, "192.241.212.23", "192.241.214.127", "192.241.220.139"                          # Your HTTP server, Apache/etc
   # TODO adding db role to production, we don't need it, but a capistrano task is looking for it
   # role :db, "192.241.214.127", :primary => true
end

# if you want to clean up old releases on each deploy uncomment this:
# NB we're doing git checkouts so this won't be necessary
# after "deploy:restart", "deploy:cleanup"

set :migrate_target,  :current
set :ssh_options,     { :forward_agent => true }
set :rails_env,       "production"
set :normalize_asset_timestamps, false

set(:latest_release)  { fetch(:current_path) }
set(:release_path)    { fetch(:current_path) }
set(:current_release) { fetch(:current_path) }

set(:current_revision)  { capture("cd #{current_path}; git rev-parse --short HEAD").strip }
set(:latest_revision)   { capture("cd #{current_path}; git rev-parse --short HEAD").strip }
set(:previous_revision) { capture("cd #{current_path}; git rev-parse --short HEAD@{1}").strip }

default_environment["RAILS_ENV"] = 'production'

# Use our ruby-1.9.2-p290@my_site gemset
# default_environment["PATH"]         = "--"
# default_environment["GEM_HOME"]     = "--"
# default_environment["GEM_PATH"]     = "--"
# default_environment["RUBY_VERSION"] = "ruby-1.9.2-p290"

default_run_options[:shell] = 'bash'

# after "deploy:update", "foreman:export"    # Export foreman scripts
# after "deploy:update", "foreman:restart"   # Restart application scripts

namespace :deploy do
  desc "Deploy your application"
  task :default do
    update
    restart
  end

  desc "Setup your git-based deployment app"
  task :setup, :except => { :no_release => true } do
    dirs = [deploy_to, shared_path]
    dirs += shared_children.map { |d| File.join(shared_path, d) }
    run "#{try_sudo} mkdir -p #{dirs.join(' ')} && #{try_sudo} chmod g+w #{dirs.join(' ')}"
    run "git clone #{repository} #{current_path}"
  end

  task :cold do
    update
    migrate
  end

  task :update do
    transaction do
      update_code
    end
  end

  desc "Update the deployed code."
  task :update_code, :except => { :no_release => true } do
    run "cd #{current_path}; git fetch origin; git reset --hard #{branch}"
    finalize_update
  end

  desc "Update the database (overwritten to avoid symlink)"
  task :migrations do
    transaction do
      update_code
    end
    migrate
    restart
  end

  task :finalize_update, :except => { :no_release => true } do
    run "chmod -R g+w #{latest_release}" if fetch(:group_writable, true)

    # mkdir -p is making sure that the directories are there for some SCM's that don't
    # save empty folders
    run <<-CMD
      rm -rf #{latest_release}/log #{latest_release}/public/system #{latest_release}/tmp/pids &&
      mkdir -p #{latest_release}/public &&
      mkdir -p #{latest_release}/tmp &&
      ln -s #{shared_path}/log #{latest_release}/log &&
      ln -s #{shared_path}/system #{latest_release}/public/system &&
      ln -s #{shared_path}/pids #{latest_release}/tmp/pids &&
      ln -sf #{shared_path}/database.yml #{latest_release}/config/database.yml
    CMD

    if fetch(:normalize_asset_timestamps, true)
      stamp = Time.now.utc.strftime("%Y%m%d%H%M.%S")
      asset_paths = fetch(:public_children, %w(images stylesheets javascripts)).map { |p| "#{latest_release}/public/#{p}" }.join(" ")
      run "find #{asset_paths} -exec touch -t #{stamp} {} ';'; true", :env => { "TZ" => "UTC" }
    end
  end

  # desc "Zero-downtime restart of Unicorn"
  # task :restart, :except => { :no_release => true } do
  #   run "kill -s USR2 `cat /tmp/unicorn.my_site.pid`"
  # end
  #
  # desc "Start unicorn"
  # task :start, :except => { :no_release => true } do
  #   run "cd #{current_path} ; bundle exec unicorn_rails -c config/unicorn.rb -D"
  # end
  #
  # desc "Stop unicorn"
  # task :stop, :except => { :no_release => true } do
  #   run "kill -s QUIT `cat /tmp/unicorn.my_site.pid`"
  # end
  #
  # namespace :rollback do
  #   desc "Moves the repo back to the previous version of HEAD"
  #   task :repo, :except => { :no_release => true } do
  #     set :branch, "HEAD@{1}"
  #     deploy.default
  #   end
  #
  #   desc "Rewrite reflog so HEAD@{1} will continue to point to at the next previous release."
  #   task :cleanup, :except => { :no_release => true } do
  #     run "cd #{current_path}; git reflog delete --rewrite HEAD@{1}; git reflog delete --rewrite HEAD@{1}"
  #   end
  #
  #   desc "Rolls back to the previously deployed version."
  #   task :default do
  #     rollback.repo
  #     rollback.cleanup
  #   end
  # end
end

# Foreman tasks

# namespace :foreman do
#   desc 'Export the Procfile to Ubuntu upstart scripts'
#   task :export, :roles => :app do

#     run "cd #{release_path} && sudo bundle exec foreman export foreman /etc/init -a #{application} -u #{user} -l #{release_path}/log/foreman"

#   end

#   desc "Start the application services"
#   task :start, :roles => :app do

#     sudo "start #{application}"
#   end

#   desc "Stop the application services"

#   task :stop, :roles => :app do
#     sudo "stop #{application}"

#   end

#   desc "Restart the application services"
#   task :restart, :roles => :app do

#     run "sudo start #{application} || sudo restart #{application}"
#   end
# end
# def run_rake(cmd)
#   run "cd #{current_path}; #{rake} #{cmd}"
# end

set :default_environment, {
  'PATH' => "$HOME/.rbenv/shims:$HOME/.rbenv/bin:$PATH"
}

# load 'deploy/assets'

namespace :deploy do
  namespace :assets do
    desc 'Run the precompile task locally and rsync with shared'
    task :precompile, :roles => :web, :except => { :no_release => true } do
      %x{bundle exec rake assets:precompile}
      hosts.each do |host|
        puts "copying to #{host}"
        %x{rsync --recursive --times --rsh=ssh --compress --human-readable --progress public/assets #{user}@#{host}:#{current_path}}
      end
      %x{bundle exec rake assets:clean}
    end
  end
end

namespace(:customs) do
  task :config, :roles => :app do
    run <<-CMD
      ln -nfs #{shared_path}/config/application.yml #{current_path}/config/application.yml
    CMD
  end
end

after "deploy:update_code", "customs:config"
