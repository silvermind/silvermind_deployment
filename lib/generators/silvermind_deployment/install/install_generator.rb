# require 'rails/generators'
#
module SilvermindDeployment
  class InstallGenerator < ::Rails::Generators::Base
    desc "This generator installs the Silvermind Deployment Templates"

    source_root File.expand_path(File.join(File.dirname(__FILE__), 'templates'))

    def copy_unicorn
      template 'unicorn.rb', 'config/unicorn.rb'
    end

  end
end