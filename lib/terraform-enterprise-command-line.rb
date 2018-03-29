require 'thor'

require 'terraform-enterprise/version'
require 'terraform-enterprise/commands/configuration_versions_command'
require 'terraform-enterprise/commands/organizations_command'
require 'terraform-enterprise/commands/workspaces_command'
require 'terraform-enterprise/commands/oauth_tokens_command'
require 'terraform-enterprise/commands/teams_command'
require 'terraform-enterprise/commands/variables_command'

module TerraformEnterprise
  # Terraform Enterprise Command Line class
  class CommandLine < Thor
    include TerraformEnterprise::Commands

    desc 'organizations <subcommand>', 'Manage organizations'
    subcommand 'organizations', OrganizationsCommand

    desc 'workspaces <subcommand>', 'Manage workspaces'
    subcommand 'workspaces', WorkspacesCommand

    desc 'oauth_tokens <subcommand>', 'Manage OAuth tokens'
    subcommand 'oauth_tokens', OAuthTokensCommand

    desc 'teams <subcommand>', 'Manage teams'
    subcommand 'teams', TeamsCommand

    desc 'variables <subcommand>', 'Manage variables'
    subcommand 'variables', VariablesCommand

    desc 'configuration_versions <subcommand>', 'Manage configuration versions'
    subcommand 'configuration_versions', ConfigurationVersionsCommand
  end
end

TerraformEnterprise::CommandLine.start(ARGV)
