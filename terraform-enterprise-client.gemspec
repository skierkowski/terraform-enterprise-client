# encoding: utf-8
$:.push File.expand_path("../lib", __FILE__)
require File.expand_path('../lib/terraform-enterprise/version', __FILE__)

Gem::Specification.new do |gem|
  gem.name          = 'terraform-enterprise-client'
  gem.authors       = [ "Maciej Skierkowski" ]
  gem.email         = 'maciej@skierkowski.com'
  gem.homepage      = 'http://github.com/skierkowski/terraform-enterprise-client'
  gem.summary       = 'Ruby client for the official Terraform Enterprise API'
  gem.description   = %q{ Ruby client that supports all of the Terraform Enterprise API methods. }
  gem.version       = TerraformEnterprise::VERSION
  gem.required_ruby_version = '>= 2.0.0'

  gem.files = Dir['{lib}/**/*']
  gem.require_paths = %w[ lib ]
  gem.extra_rdoc_files = ['LICENSE', 'README.md']

  gem.add_dependency 'rest-client', '~> 2.0.2'
  gem.add_dependency 'colorize', '~> 0.8.1'
  gem.add_dependency 'thor', '~> 0.20.0'
end