require 'terraform-enterprise/commands/command'

module TerraformEnterprise
  module Commands
    class OrganizationsCommand < TerraformEnterprise::Commands::Command
      class_option :host, type: :string
      class_option :token, type: :string

      desc 'list', 'Lists all organizations'
      def list
        render client.organizations.list
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
