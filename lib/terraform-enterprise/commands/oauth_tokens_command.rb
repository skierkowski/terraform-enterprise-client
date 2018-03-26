require 'terraform-enterprise/commands/command'
require 'terraform-enterprise-client'

module TerraformEnterprise
  module Commands
    class OAuthTokensCommand < TerraformEnterprise::Commands::Command
      class_option :organization, required: true, type: :string, desc: STRINGS[:oauth_tokens][:attributes][:organization]

      desc 'list', STRINGS[:oauth_tokens][:commands][:list]
      option :table, type: :boolean, default: true, desc: STRINGS[:options][:table]
      def list
        render client.oauth_tokens.list(options)
      end
    end
  end
end
