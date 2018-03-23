require 'terraform-enterprise/commands/command'

module TerraformEnterprise
  module Commands
    class WorkspacesCommand < TerraformEnterprise::Commands::Command
      class_option :host, type: :string, desc: 'Hostname of private Terraform Enterprise'
      class_option :token, type: :string, desc: 'Access token'
      class_option :organization, required: true, type: :string, desc: 'Organization name'

      desc 'list', 'Lists all workspaces in the organization'
      def list
        render client.workspaces.list(options)
      end

      desc 'create <name>', 'Creates a new organization'
      option :terraform_version, type: :string, desc: "Version of Terraform to use for this workspace."
      option :working_directory, type: :string, desc: "Relative path that Terraform will execute within."
      option :oauth_token, type: :string, desc: 'VCS Connection (OAuth Conection + Token) to use as identified; obtained from the oauth_tokens subcommand.'
      option :branch, type: :string, desc: "Repository branch that Terraform will execute from."
      option :ingress_submodules, type: :boolean, default: false, desc: "Submodules should be fetched when cloning the VCS repository."
      option :repo, type: :string, desc: 'Reference to VCS repository in the format :org/:repo'
      option :import_repo, type: :string, desc: ''
      def create(name)
        params = {
          organization: options[:organization],
          name: name,
          'working-directory' => options[:working_directory] || '',
          'vcs-repo' => {
            'branch'             => options[:branch] || '',
            'identifier'         => options[:repo] || '',
            'oauth-token-id'     => options[:oauth_token] || '',
            'ingress-submodules' => options[:ingress_submodules]
          }
        }

        params['migration-environment'] = options[:import_repo] if options[:import_repo]
        params['terraform_version']     = options[:terraform_version] if options[:terraform_version]
        
        render client.workspaces.create(params)
      end

      desc 'get <name>', 'Gets the workspace details'
      def get(name)
        params = {
          organization: options[:organization],
          workspace: name
        }
        render client.workspaces.get(params)
      end

      desc 'delete <name>', 'Deletes the workspace'
      def delete(name)
        params = {
          organization: options[:organization],
          workspace: name
        }
        render client.workspaces.delete(params)
      end

      desc 'update <name>', 'Update the workspace'
      option :working_directory, type: :string, desc: "Relative path that Terraform will execute within."
      option :terraform_version, type: :string, desc: "Version of Terraform to use for this workspace."
      option :auto_apply, type: :boolean, desc: 'Auto-apply enabled'
      def update(name)
        params = options
        params[:workspace] = name
        render client.workspaces.update(params)
      end

      desc 'lock <id>', "Locks the workspace"
      def lock(id)
        render client.workspaces.action(action: :lock, id: id)
      end

      desc 'unlock <id>', 'Unlocks the workspace'
      def unlock(id)
        render client.workspaces.action(action: :unlock, id: id)
      end
    end
  end
end
