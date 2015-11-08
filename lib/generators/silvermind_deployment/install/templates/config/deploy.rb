# config valid only for current version of Capistrano
lock '3.4.0'

set :application, 'TODO: your app name'
set :repo_url, 'TODO: your rails app git repo url'

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
# set :deploy_to, "/home/app_path"

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/secrets.yml')

# Default value for linked_dirs is []
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system', 'public/uploads')

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5


### EYE
set :eye_roles, -> { :app }
set :eye_env, -> { {rails_env: fetch(:rails_env)} }
set :eye_config_file, -> { "#{current_path}/config/eye/#{fetch :rails_env}.rb" }


### Rollbar Deploy Pings
set :rollbar_token, 'TODO: your rollbar server side token for deployment notifications'
set :rollbar_env, Proc.new { fetch :stage }
set :rollbar_role, Proc.new { :app }


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

namespace :eye do

  task :start do
    on roles(fetch(:eye_roles)), in: :groups, limit: 3, wait: 10 do
      within current_path do
        with fetch(:eye_env) do
          execute :bundle, "exec eye start #{fetch(:eye_app_name)}"
        end
      end
    end
  end

  task :stop do
    on roles(fetch(:eye_roles)), in: :groups, limit: 3, wait: 10 do
      within current_path do
        with fetch(:eye_env) do
          execute :bundle, "exec eye stop #{fetch(:eye_app_name)}"
        end
      end
    end
  end

  task :restart do
    on roles(fetch(:eye_roles)), in: :groups, limit: 3, wait: 10 do
      within current_path do
        with fetch(:eye_env) do
          execute :bundle, "exec eye restart #{fetch(:eye_app_name)}"
        end
      end
    end
  end

  desc "Start eye with the desired configuration file"
  task :load_config do
    on roles(fetch(:eye_roles)) do
      within current_path do
        with fetch(:eye_env) do
          execute :bundle, "exec eye quit"
          execute :bundle, "exec eye load #{fetch(:eye_config_file)}"
        end
      end
    end
  end

end
before "deploy:finished", "eye:load_config"
after "deploy:finished", "eye:restart"
