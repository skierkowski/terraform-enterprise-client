require 'thor'

require 'terraform-enterprise/version'
require 'terraform-enterprise/commands/organizations_command'
require 'terraform-enterprise/commands/workspaces_command'
require 'terraform-enterprise/commands/oauth_tokens_command'

module TerraformEnterprise
  class CommandLine < Thor
    desc 'organizations <subcommand>', 'Manage organizations'
    subcommand 'organizations', TerraformEnterprise::Commands::OrganizationsCommand

    desc 'workspaces <subcommand>', 'Manage workspaces'
    subcommand 'workspaces', TerraformEnterprise::Commands::WorkspacesCommand

    desc 'oauth_tokens <subcommand>', 'Manage OAuth tokens'
    subcommand 'oauth_tokens', TerraformEnterprise::Commands::OAuthTokensCommand
  end
end

TerraformEnterprise::CommandLine.start(ARGV)