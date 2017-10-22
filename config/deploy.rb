# config valid only for current version of Capistrano
lock "3.9.1"

set :application, "semi"
set :repo_url, "git@github.com:kensuke-m/semi.git"

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, "/usr/local/www/semi"

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
append :linked_files, "config/database.yml", "config/secrets.yml"

# Default value for linked_dirs is []
append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "vendor/bundle", "public/system"

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
# set :keep_releases, 5

set :rbenv_type, :user
set :rbenv_ruby, '2.3.4'
set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} CONFIGURE_ARGS='with-sqlite3-include=/usr/local/include with-sqlite3-lib=/usr/local/lib' rbenv exec"
set :rbenv_map_bins, %w{rake gem bundle ruby rails}
set :rbenv_roles, :all

set :log_level, :warn

set :unicorn_pid, "#{shared_path}/tmp/pids/unicorn.pid"

set :unicorn_config_path, -> { File.join(current_path, "config", "unicorn.rb") }

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
    invoke 'unicorn:restart'
  end
end
