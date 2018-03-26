require 'thor'

require 'terraform-enterprise/version'
require 'terraform-enterprise/commands/organizations_command'
require 'terraform-enterprise/commands/workspaces_command'
require 'terraform-enterprise/commands/oauth_tokens_command'
require 'terraform-enterprise/commands/teams_command'
require 'terraform-enterprise/commands/variables_command'

module TerraformEnterprise
  class CommandLine < Thor
    desc 'organizations <subcommand>', 'Manage organizations'
    subcommand 'organizations', TerraformEnterprise::Commands::OrganizationsCommand

    desc 'workspaces <subcommand>', 'Manage workspaces'
    subcommand 'workspaces', TerraformEnterprise::Commands::WorkspacesCommand

    desc 'oauth_tokens <subcommand>', 'Manage OAuth tokens'
    subcommand 'oauth_tokens', TerraformEnterprise::Commands::OAuthTokensCommand

    desc 'teams <subcommand>', 'Manage teams'
    subcommand 'teams', TerraformEnterprise::Commands::TeamsCommand

    desc 'variables <subcommand>', 'Manage variables'
    subcommand 'variables', TerraformEnterprise::Commands::VariablesCommand
  end
end

TerraformEnterprise::CommandLine.start(ARGV)