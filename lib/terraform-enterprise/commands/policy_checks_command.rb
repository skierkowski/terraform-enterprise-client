require 'terraform-enterprise/commands/command'
require 'terraform-enterprise/commands/util'

module TerraformEnterprise
  module Commands
    # Configuration Version Commoand
    class PolicyChecksCommand < TerraformEnterprise::Commands::Command
      include TerraformEnterprise::Util::Tar

      ATTR_STR = STRINGS[:policy_checks][:attributes]
      CMD_STR = STRINGS[:policy_checks][:commands]

      desc 'list', CMD_STR[:list]
      option :table, type: :boolean, default: false, desc: STRINGS[:options][:table]
      option :run_id, required: true, type: :string, desc: ATTR_STR[:run_id]
      def list
        render client.policy_checks.list(run_id: options[:run_id])
      end

      desc 'override <policy-check-id>', CMD_STR[:override]
      option :comment, type: :string, desc: ATTR_STR[:comment]
      def override(id)
        params = { id: id, action: :override }
        params[:comment] = options[:comment] if options[:comment]
        render client.policy_checks.action(params)
      end
    end
  end
end
