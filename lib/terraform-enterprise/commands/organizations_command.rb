require 'terraform-enterprise/commands/command'

module TerraformEnterprise
  module Commands
    class OrganizationsCommand < TerraformEnterprise::Commands::Command

      desc 'list', 'Lists all organizations'
      option :table, type: :boolean, default: true, desc: 'Format output in a table'
      def list
        render client.organizations.list, only: [:id, :name, 'created-at', :email]
      end

      desc 'create <name> <email>', 'Creates a new organization'
      def create(name, email)
        render client.organizations.create(name: name, email: email)
      end

      desc 'get <name>', 'Gets the organization details'
      def get(name)
        render client.organizations.get(name:name)
      end

      desc 'delete <name>', 'Deletes the organization'
      def delete(name)
        render client.organizations.delete(name:name)
      end
    end
  end
end
