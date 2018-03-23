require 'terraform_enterprise_api/commands/command'
require 'terraform_enterprise_api'

module TerraformEnterprise
  module Commands
    class OAuthTokensCommand < TerraformEnterprise::Commands::Command
      class_option :host, type: :string
      class_option :token, type: :string
      class_option :organization, required: true, type: :string, desc: 'Organization name'

      desc 'list', 'Lists all OAuth Tokens'
      def list
        render client.oauth_tokens.list(options)
      end
    end
  end
end
