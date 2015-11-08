# require 'rails/generators'
#
module SilvermindDeployment
  class InstallGenerator < ::Rails::Generators::Base
    desc "This generator installs the Silvermind Deployment Templates"

    source_root File.expand_path(File.join(File.dirname(__FILE__), 'templates'))

    def copy_unicorn
      # Capistrano
      template 'Capfile', 'Capfile'
      template 'config/deploy.rb', 'config/deploy.rb'
      template 'config/deploy/production.rb', 'config/deploy/production.rb'

      # Eye
      template 'config/eye/production.rb', 'config/eye/production.rb'

      # Unicorn
      template 'config/unicorn.rb', 'config/unicorn.rb'

      # Rollbar
      template 'initializers/rollbar.rb', 'initializers/rollbar.rb'

    end

  end
end
