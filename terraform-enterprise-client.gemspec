# encoding: utf-8
$:.push File.expand_path("../lib", __FILE__)
require 'terraform-enterprise/version'

Gem::Specification.new do |gem|
  gem.name                  = 'terraform-enterprise-client'
  gem.authors               = [ "Maciej Skierkowski" ]
  gem.email                 = 'maciej@skierkowski.com'
  gem.homepage              = 'http://github.com/skierkowski/terraform-enterprise-client'
  gem.summary               = 'Ruby client for the official Terraform Enterprise API'
  gem.description           = %q{ Ruby client that supports all of the Terraform Enterprise API methods. }
  gem.license               = 'MPL-2.0'
  gem.version               = TerraformEnterprise::VERSION
  gem.required_ruby_version = '>= 2.3.0'  
  gem.files                 = Dir['{lib}/**/*']
  gem.executables           = ['tfe']
  gem.require_paths         = %w[ lib ]
  gem.extra_rdoc_files      = ['LICENSE', 'README.md']

  gem.add_dependency 'rest-client', '~> 2.0', '>= 2.0.2'
  gem.add_dependency 'colorize', '~> 0.8', '>= 0.8.1'
  gem.add_dependency 'thor', '~> 0.20', '>= 0.20.0'
  gem.add_dependency 'terminal-table', '~> 1.8', '>= 1.8.0'
end