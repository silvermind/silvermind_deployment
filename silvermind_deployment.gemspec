# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'silvermind_deployment/version'

Gem::Specification.new do |spec|
  spec.name          = "silvermind_deployment"
  spec.version       = SilvermindDeployment::VERSION
  spec.authors       = ["Severin Ulrich"]
  spec.email         = ["sulrich@downloads.ch"]

  spec.summary       = %q{Simplified Deployment using Capistrano, Unicorn and Eye}
  spec.description   = %q{Simplified Deployment using Capistrano, Unicorn and Eye}
  spec.homepage      = "https://github.com/silvermind/silvermind_deployment"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "https://rubygems.org"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.9"
  spec.add_development_dependency "rake", "~> 10.0"

  #####################################################
  # Eye
  #####################################################

  spec.add_runtime_dependency "eye", "0.8.pre2" #git: "git@github.com:kostya/eye.git", tag: "v0.8.pre"

  #####################################################
  # Unicorn
  #####################################################

  spec.add_runtime_dependency "unicorn", ">= 5.0.0"

  #####################################################
  # Error Reporting
  #####################################################

  spec.add_runtime_dependency "rollbar"

  #####################################################
  # Capistrano Deployment
  #####################################################

  spec.add_development_dependency 'capistrano', '>= 3.4.0'
  spec.add_development_dependency 'capistrano-rails' #, require: false # deployment rails hooks
  spec.add_development_dependency 'capistrano-bundler' #, require: false # deployment bundler hooks
  spec.add_development_dependency 'capistrano-rbenv'
  spec.add_development_dependency 'capistrano-rbenv-install'

end
