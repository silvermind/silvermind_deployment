# server-based syntax
# ======================
# Defines a single server with a list of roles and multiple properties.
# You can define all roles on a single server, or split them:

set :deploy_to, "/home/TODO: app_path"

server '#TODO YOUR-SERVER-URL', user: 'TODO: USER-NAME', roles: %w{app db web}

set :rails_env, "production"

set :eye_app_name, "TODO: YOUR-EYE-APP-NAME"

### RUBY
set :rbenv_ruby, '2.2.2'
set :rbenv_type, :user
set :rbenv_map_bins, %w{rake gem bundle ruby rails unicorn}
set :rbenv_prefix, "RAILS_ENV=#{fetch(:rails_env)} RACK_ENV=#{fetch(:rails_env)} #{fetch(:rbenv_path)}/bin/rbenv exec"
