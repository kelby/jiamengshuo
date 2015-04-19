# config valid only for current version of Capistrano
lock '3.4.0'

# Important: First time you need 'brew install ssh-copy-id'
# $ ssh-copy-id user_name@found_mentor.com

# server "foundmentor.com", :web, :app, :db, primary: true
server 'foundmentor.com', user: 'deployer', roles: %w{web app db}

set :application, 'found_mentor'
set :repo_url, 'git@bitbucket.org:lkelby/found_mentor.git'

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

set :user, "deploy"
set :deploy_via, :copy
set :use_sudo, false

set :scm, "git"
set :repository,  "git@bitbucket.org:lkelby/found_mentor.git"
set :branch, "master"

set :stages, %w[production staging]
set :default_stage, 'production'
set :rails_env, "production"

set :keep_releases,   10

# set unicorn_config_path
set :unicorn_config_path, -> { File.join(current_path, "config", "unicorn.rb") }

# ssh_options[:forward_agent] = true
# ssh_options[:port] = 1000
set :ssh_options, {:forward_agent => true}

after "deploy", "deploy:cleanup"

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, '/var/www/found_mentor'

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/secrets.yml')

# Default value for linked_dirs is []
# set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system')

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5
set :linked_files, %w{config/database.yml config/mailer.yml config/redis.yml config/secrets.yml config/sidekiq.yml config/initializers/devise.rb}
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/images public/uploads}

namespace :deploy do

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

end

after 'deploy:publishing', 'deploy:restart'
namespace :deploy do
  task :restart do
    invoke 'unicorn:reload'
  end
end
