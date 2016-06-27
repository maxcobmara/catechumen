require 'capistrano/ext/multistage'
#require 'capistrano/rvm'
#require 'capistrano/bundler'
#require 'capistrano/rails'
 
set :application, "catechumen"
set :repository,  "git@github.com:maxcobmara/catechumen.git"

set :scm, :git 

set :user, "nurhashimah"
set :stages, ["staging", "production"]
set :default_stage, "staging"

set :branch, "master"
set :rails_env, "production"
set :deploy_via, :copy
set :ssh_options, {:forward_agent => true, :port => 4321}

set :default_environment, {
  'PATH' => "/home/nurhashimah/.rvm/gems/ruby-1.8.7-p374@catechumen/bin:/home/nurhashimah/.rvm/gems/ruby-1.8.7-p374@global/bin:/home/nurhashimah/.rvm/rubies/ruby-1.8.7-p374/bin:/home/nurhashimah/.rvm/bin:$PATH",
  'RUBY_VERSION' => 'ruby-1.8.7-p374',
  'GEM_HOME' => '/home/nurhashimah/.rvm/gems/ruby-1.8.7-p374@catechumen',
  'GEM_PATH' => '/home/nurhashimah/.rvm/gems/ruby-1.8.7-p374@catechumen:/home/nurhashimah/.rvm/gems/ruby-1.8.7-p374@global' 
}

set :linked_files, fetch(:linked_files, []).push('config/database.yml')
# set path to application
#shared_path = "/opt/app/catechumen/current/shared"

# shall remove 'No such file or directory' error for Public subfolders
set :normalize_asset_timestamps, false

#pid_file = "/opt/app/catechumen/tmp/pids/server.pid"
pid_file = "/opt/app/catechumen/current/tmp/pids/thin.pid"

namespace :deploy do
   task :start do
     run "cd /opt/app/catechumen/current; thin -d start -p 3000 -e production"
   end
   task :stop do 
     run "kill -s QUIT `cat #{pid_file}`" if File.exists?(pid_file)
   end
   task :restart do
     stop
     sleep 2
     start
   end
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#   end

end