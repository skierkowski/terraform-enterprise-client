require 'terraform-enterprise/commands/command'
require 'terraform-enterprise-client'

module TerraformEnterprise
  module Commands
    class OAuthTokensCommand < TerraformEnterprise::Commands::Command
      class_option :organization, required: true, type: :string, desc: 'Organization name'

      desc 'list', 'Lists all OAuth Tokens'
      option :table, type: :boolean, default: true, desc: 'Format output in a table'
      def list
        render client.oauth_tokens.list(options)
      end
    end
  end
end
