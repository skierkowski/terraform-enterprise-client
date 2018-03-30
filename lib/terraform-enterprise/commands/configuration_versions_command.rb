require 'terraform-enterprise/commands/command'
require 'terraform-enterprise/commands/util'

module TerraformEnterprise
  module Commands
    # Configuration Version Commoand
    class ConfigurationVersionsCommand < TerraformEnterprise::Commands::Command
      include TerraformEnterprise::Util::Tar

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

      desc 'upload <path> <upload-url>', CMD_STR[:upload]
      def upload(path, url)
        full_path = File.expand_path(path)
        content =
          if File.directory?(full_path)
            gzip(tar(full_path))
          else
            File.read(full_path)
          end

        params = { content: content, url: url }

        render client.configuration_versions.upload(params)
      end
    end
  end
end
