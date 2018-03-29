require 'terraform-enterprise/commands/command'

module TerraformEnterprise
  module Commands
    # COnfiguration Version Commoand
    class ConfigurationVersionsCommand < TerraformEnterprise::Commands::Command
      ATTR_STR = STRINGS[:configuration_versions][:attributes]
      CMD_STR = STRINGS[:configuration_versions][:commands]

      desc 'list', CMD_STR[:list]
      option :table, type: :boolean, default: true, desc: STRINGS[:options][:table]
      option :workspace_id, required: true, type: :string, desc: 'workspace id'
      def list
        render client.configuration_versions.list(workspace: options[:workspace_id])
      end

      desc 'create', CMD_STR[:list]
      option :workspace_id, required: true, type: :string, desc: STRINGS[:options][:workspace_id]
      def create
        render client.configuration_versions.create(workspace: options[:workspace_id])
      end

      desc 'get <id>', CMD_STR[:get]
      def get(id)
        render client.configuration_versions.get(id: id)
      end

      desc 'upload <path> <url>', CMD_STR[:upload]
      def upload(path, url)
        params = {
          content: File.read(File.expand_path(path)),
          url: url
        }

        render client.configuration_versions.upload(params)
      end
    end
  end
end
