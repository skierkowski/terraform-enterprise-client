require 'terraform-enterprise/commands/command'

module TerraformEnterprise
  module Commands
    class RunsCommand < TerraformEnterprise::Commands::Command
      ATTR_STR = STRINGS[:runs][:attributes]
      CMD_STR = STRINGS[:runs][:commands]

      desc 'list', CMD_STR[:list]
      option :table, type: :boolean, default: true, desc: STRINGS[:options][:table]
      option :workspace_id, required: true, type: :string, desc: ATTR_STR[:workspace_id]
      def list
        render client.runs.list(id: options[:workspace_id]), except: [:permissions]
      end

      desc 'create', CMD_STR[:create]
      option :workspace_id, required: true, type: :string, desc: ATTR_STR[:workspace_id]
      option :configuration_version_id, type: :string, desc: ATTR_STR[:configuration_version_id]
      option :destroy, type: :boolean, default: false, desc: ATTR_STR[:destroy]
      def create
        render client.runs.create(options), except: [:permissions]
      end

      desc 'get <id>', CMD_STR[:get]
      def get(id)
        render client.runs.get(id: id), except: [:permissions]
      end

      desc 'apply <id>', CMD_STR[:apply]
      option :comment, type: :string, desc: ATTR_STR[:comment]
      def apply(id)
        params = { id: id, action: :apply }
        params[:comment] = options[:comment] if options[:comment]
        render client.runs.action(params)
      end

      desc 'discard <id>', CMD_STR[:discard]
      option :comment, type: :string, desc: ATTR_STR[:comment]
      def discard(id)
        params = { id: id, action: :discard }
        params[:comment] = options[:comment] if options[:comment]
        render client.runs.action(params)
      end
    end
  end
end
